class AbstractCell < Cell::Rails
  include Habanero::PlacementsHelper

  def show(options)
    instance_variables_from(options)
    render
  end
  
  protected

  def instance_variables_from(options)
    options.each { |k, v| instance_variable_set("@#{k}", v) }
  end
  
end
