module Habanero
  class AbstractCell < Cell::Rails
    helper 'habanero/cells'
    helper 'habanero/pages'

    layout 'scoop'

    protected

    def instance_variables_from(options)
      options.each { |k, v| instance_variable_set("@#{k}", v) }
    end
  end
end
