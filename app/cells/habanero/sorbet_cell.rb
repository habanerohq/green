module Habanero
  class SorbetCell < Habanero::AbstractCell
    def show(options)
      instance_variables_from(options)
      render
    end
    
    def edit(options)
      instance_variables_from(options)
      render
    end
  end
end