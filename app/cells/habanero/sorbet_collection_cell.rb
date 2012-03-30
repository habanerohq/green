module Habanero
  class SorbetCollectionCell < Habanero::AbstractCell
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
      if data = params[@placement.params_key]
        @targets = data.reduce(@targets) do |result, (method, direction)|

          if klass_by_precedence.column_names.include?(method)
            result.order("#{method} #{direction}")

          else
            k = klass_by_precedence.reflect_on_association(method.to_sym).klass
            tn = k.table_name
            cn = (k.column_names.include?('name') ? 'name' : 'id') # todo: what to do if name is not the same as to_s
            result.includes(method).order("#{tn}.#{cn} #{direction}")
          end
        end
      else
        @targets = @targets.order(@sorbet.klass.to_s_methods)
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
      @sorbet = sorbet_by_precedence
      @search = @placement.search
      @targets = targets_by_precedence
      @ingredients = ingredients_by_precedence

      if @placement.scoop.paginate?
        @targets = @targets.page(params[:page])
      end
    end
    
    def klass_by_precedence
      @query.try(:klass) || @sorbet.try(:klass)
    end
    
    def sorbet_by_precedence
      @query.try(:sorbet) || @mask.try(:sorbet) || @page.nearest_target
    end
    
    def targets_by_precedence
      @search.try(:query_chain) || @query.try(:evaluate, params) || (@sorbet.klass.unscoped if @sorbet.present?) || []
    end
    
    def ingredients_by_precedence
      @placement.ingredients || @sorbet.try(:all_displayable_ingredients)
    end
    
    def roots_only
      @mask.sorbet.klass.respond_to?(:roots) ? @targets.where(:parent_id => nil) : @targets
    end
  end
end
