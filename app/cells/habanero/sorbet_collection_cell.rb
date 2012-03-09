module Habanero
  class SorbetCollectionCell < Habanero::AbstractCell
    def list(options)
      instance_variables_from(options)
      @query = @placement.scoop.query
      @targets = @query.evaluate(params)
      @ingredients = @placement.scoop.mask ? @placement.scoop.mask.mask_ingredients.map(&:ingredient) : @query.sorbet.all_displayable_ingredients
      render
    end

    def table(options)


      list(options)
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
  end
end
