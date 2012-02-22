module Habanero
  class SorbetCollectionCell < Habanero::AbstractCell

    def list(options)
      instance_variables_from(options)
      @targets = @page.target_class.order(:name)
      render
    end 

    def tree(options)
      instance_variables_from(options)
      @targets = @page.target_class.order(:name)
      render
    end 

  end
end