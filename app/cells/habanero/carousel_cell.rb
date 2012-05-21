class Habanero::CarouselCell < Habanero::AbstractCell
  def show(options)
    instance_variables_from(options)
    @features = @feature.children

    render
  end
end
