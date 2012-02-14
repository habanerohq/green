module Habanero
  class AbstractCollectionCell < Habanero::AbstractCell

    def list(options)
      instance_variables_from(options)
      @targets = @page.target_class.order(:name)
      render
    end 

  end
end