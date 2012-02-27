module Habanero
  class SorbetCell < Habanero::AbstractCell
    def show(options)
      instance_variables_from(options)

      @sorbet = Habanero::Sorbet.find(params[:sorbet_type])
      @target = @sorbet.klass.find(params[:id])
      @ingredients = @placement.scoop.mask ? @placement.scoop.mask.mask_ingredients.map(&:ingredient) : @target._sorbet.ingredients

      render
    end

    def edit(options)
      instance_variables_from(options)
      render
    end
  end
end
