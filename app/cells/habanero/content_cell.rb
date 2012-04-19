class Habanero::ContentCell < Habanero::AbstractCell
  def show(options)
    instance_variables_from(options)
    @feature = @placement.feature

    render
  end

  def hero(options)
    instance_variables_from(options)
    @feature = @placement.feature

    render
  end
end
