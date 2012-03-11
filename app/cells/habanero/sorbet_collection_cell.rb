module Habanero
  class SorbetCollectionCell < Habanero::AbstractCell
    def list(options)
      _list(options)
      render
    end

    def table(options)
      _list(options)
      if data = params["placement_#{@placement.id}"]
        @targets = data.reduce(@targets) do |result, (method, direction)|
          if @query.klass.column_names.include?(method)
            result.order("#{method} #{direction}")
          else
            k = @query.klass.reflect_on_association(method.to_sym).klass
            tn = k.table_name
            cn = (k.column_names.include?('name') ? 'name' : 'id') # todo: what to do if name is not the same as to_s
            result.includes(method).order("#{tn}.#{cn} #{direction}")
          end
        end
      end
      render
    end

    def tree(options)
      instance_variables_from(options)
      @mask = @placement.scoop.mask
      @targets = @mask.sorbet.klass.order(:name)
      render
    end

    def tree_node(targets, mask)
      @mask = mask
      @targets = targets
      render
    end

    def navigation(options)
      list(options)
    end
    
    protected

    def _list(options)
      instance_variables_from(options)
      @query = @placement.scoop.query
      @targets = @query.evaluate(params)
      @ingredients = @placement.scoop.mask ? @placement.scoop.mask.mask_ingredients.map(&:ingredient) : @query.sorbet.all_displayable_ingredients
    end
  end
end
