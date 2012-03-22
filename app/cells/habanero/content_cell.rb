class Habanero::ContentCell < Habanero::AbstractCell
  def show(options)
    instance_variables_from(options)
    @scoop = @placement.scoop

    render
  end

  def hero(options)
    instance_variables_from(options)
    @scoop = @placement.scoop

    render
  end
end
