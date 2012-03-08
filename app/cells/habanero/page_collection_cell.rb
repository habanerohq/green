module Habanero
  class PageCollectionCell < Habanero::SorbetCollectionCell
    def button_group(options)
      instance_variables_from(options)
      @query = @placement.scoop.query
      @targets = @query.evaluate(params)
      render
    end
  end
end
