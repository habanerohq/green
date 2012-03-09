module Habanero
  class SorbetCollectionCell < Habanero::AbstractCell
    def list(options)
      instance_variables_from(options)
      @query = @placement.scoop.query
      @targets = @query.evaluate(params)
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
