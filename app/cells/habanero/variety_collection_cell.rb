module Habanero
  class VarietyCollectionCell < Habanero::AbstractCell
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
            cn = @variety.name_ingredient_column_name
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
      @mask = @placement.scoop.mask
      @targets = roots_only
      render
    end

    def tree_node(targets, mask)
      @mask = mask
      @targets = targets
      render
    end

    protected

    def _list(options)
      instance_variables_from(options)
      @query = @placement.query
      @mask = @placement.scoop.mask
      @variety = variety_by_precedence
      @search = @placement.search
      @targets = targets_by_precedence
      @ingredients = ingredients_by_precedence

      if @targets.any? and @placement.scoop.paginate?
        @targets = @targets.page(params[:page])
      end
    end
    
    def klass_by_precedence
      @query.try(:klass) || @variety.try(:klass)
    end
    
    def variety_by_precedence
      @query.try(:variety) || @mask.try(:variety) || @page.nearest_target
    end
    
    def targets_by_precedence
      @search.try(:query_chain) || @query.try(:evaluate, params) || (@variety.klass.unscoped if @variety.present?) || []
    end
    
    def ingredients_by_precedence
      @placement.ingredients || @variety.try(:all_displayable_ingredients)
    end
    
    def roots_only
      @mask.variety.klass.respond_to?(:roots) ? @targets.where(:parent_id => nil) : @targets
    end
  end
end