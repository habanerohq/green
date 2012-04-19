module Habanero
  class CollectiveVarietyCell < Habanero::AbstractCell
    def list(options)
      _list(options)
      render
    end

    def search(options)
      _list(options)
      render
    end

    def table(options)
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
        @targets = @targets.order("#{@variety.klass.table_name}.#{@variety.klass.to_s_methods}")
      end
      render
    end

    def tree(options)
      _list(options)
      @sieve = @placement.feature.sieve
      @targets = roots_only
      render
    end

    def tree_node(targets, sieve)
      @sieve = sieve
      @targets = targets
      render
    end

    protected

    def _list(options)
      instance_variables_from(options)
      @grader = @placement.grader
      @sieve = @placement.feature.sieve
      @variety = variety_by_precedence
      @search = @placement.search
      @targets = targets_by_precedence
      @traits = traits_by_precedence

      if @targets.any? and @placement.feature.paginate?
        @targets = @targets.page(params[:scene])
      end
    end
    
    def klass_by_precedence
      @grader.try(:klass) || @variety.try(:klass)
    end
    
    def variety_by_precedence
      @grader.try(:variety) || @sieve.try(:variety) || @scene.nearest_target
    end
    
    def targets_by_precedence
      @search.try(:grader_chain) || @grader.try(:evaluate, params) || (@variety.klass.unscoped if @variety.present?) || []
    end
    
    def traits_by_precedence
      @placement.traits || @variety.try(:all_displayable_traits)
    end
    
    def roots_only
      @sieve.variety.klass.respond_to?(:roots) ? @targets.where(:parent_id => nil) : @targets
    end
  end
end
