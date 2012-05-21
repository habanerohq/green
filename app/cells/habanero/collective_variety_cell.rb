module Habanero
  class CollectiveVarietyCell < Habanero::AbstractCell
    def list(options)
      _list(options)
      @label_trait = @highlighter.try(:traits).try(:first)
      render
    end

    def list_dashboard(options)
      _list(options)
      @label_trait = @highlighter.traits.first if @highlighter.present?
      render
    end

    def search(options)
      _list(options)
      render
    end

    def grid(options)
      _list(options)
      if @targets.any? and data = params[@placement.params_key]
        @targets = data.reduce(@targets) do |result, (method, direction)|
          if klass_by_precedence.column_names.include?(method)
            result.order("#{method} #{direction}")

          else
            k = klass_by_precedence.reflect_on_association(method.to_sym).klass
            tn = k.table_name
            cn = @variety.name_trait_column_name
            result.includes(method).order("#{tn}.#{cn} #{direction}")
          end
        end
      else
        @targets = @targets.order("#{@variety.klass.table_name}.#{@variety.klass.to_s_method_names}") if @variety.klass.respond_to?(:to_s_method_names)
      end
      render
    end

    def trellis(options)
      _list(options)
      @highlighter = @feature.highlighter
      @targets = roots_only
      render
    end

    def trellis_node(targets, highlighter)
      @highlighter = highlighter
      @targets = targets
      render
    end

    protected

    def _list(options)
      instance_variables_from(options)
      @grader = @placement.grader
      @highlighter = @feature.highlighter
      @variety = variety_by_precedence
      @search = @placement.search
      @targets = targets_by_precedence
      @traits = traits_by_precedence

      if @targets.any? and @feature.paginate?
        @targets = @targets.page(params[:page])
      end
    end
    
    def klass_by_precedence
      @grader.try(:klass) || @variety.try(:klass)
    end
    
    def variety_by_precedence
      @grader.try(:variety) || @highlighter.try(:variety) || @feature.try(:variety) || @scene.nearest_target
    end
    
    def targets_by_precedence
      @search.try(:grader_chain) || @grader.try(:evaluate, params) || (@variety.klass.unscoped if @variety.present?) || []
    end
    
    def traits_by_precedence
      @placement.traits || @variety.try(:all_displayable_traits)
    end
    
    def roots_only
      @highlighter.variety.klass.respond_to?(:roots) ? @targets.where(:parent_id => nil) : @targets
    end
  end
end
