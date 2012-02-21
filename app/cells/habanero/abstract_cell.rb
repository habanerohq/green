module Habanero
  class AbstractCell < Cell::Rails
    helper 'habanero/cells'
  
    protected

    def instance_variables_from(options)
      options.each { |k, v| instance_variable_set("@#{k}", v) }
    end
  end
end