module Habanero
  class AbstractCell < Cell::Rails
    helper 'habanero/cells'
    helper 'habanero/scenes'

    layout 'feature'

    protected

    def instance_variables_from(options)
      options.each { |k, v| instance_variable_set("@#{k}", v) }
    end

    def redirect_to(*args) parent_controller.redirect_to(*args) ; end
  end
end
