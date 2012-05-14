class Habanero::ContentCell < Habanero::AbstractCell
  def show(options)
    instance_variables_from(options)
    render
  end

  def hero(options)
    instance_variables_from(options)
    render
  end
end
