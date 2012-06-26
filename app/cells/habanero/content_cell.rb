class Habanero::ContentCell < Habanero::AbstractCell
  def hero(options)
    instance_variables_from(options)
    render
  end
end
