module Habanero
  class SorbetCell < Habanero::AbstractCell
    include Habanero::PagesHelper

    def show(options)
      instance_variables_from(options)

      @sorbet = Habanero::Sorbet.find(params[:sorbet_type])
      @target = @sorbet.klass.find(params[:id])
      @ingredients = @placement.scoop.mask ? @placement.scoop.mask.mask_ingredients.map(&:ingredient) : @target._sorbet.all_displayable_ingredients

      render
    end

    def edit(options)
      instance_variables_from(options)

      @sorbet = Habanero::Sorbet.find(params[:sorbet_type])
      @target = @sorbet.klass.find(params[:id])
      @ingredients = @placement.scoop.mask ? @placement.scoop.mask.mask_ingredients.map(&:ingredient) : @target._sorbet.all_displayable_ingredients

      if request.delete?
        if @target.destroy
          # todo: redirect somewhere
        end
      end

      if @placement.params_key && request.put?
        @target.update_attributes(@placement.params_key)
        parent_controller.redirect_to page_path(@placement.scoop.page || @page, :id => @target, :sorbet_type => @target._sorbet)
      end

      render
    end

    def new(options)
      instance_variables_from(options)

      @sorbet = Habanero::Sorbet.find(params[:sorbet_type])
      @target = @sorbet.klass.new(@placement.params_key)
      @ingredients = @placement.scoop.mask ? @placement.scoop.mask.mask_ingredients.map(&:ingredient) : @target._sorbet.all_displayable_ingredients

      if @placement.params_key && request.post?
        if @target.save
          parent_controller.redirect_to page_path(@placement.scoop.page || @page, :id => @target, :sorbet_type => @target._sorbet)
        end
      end

      render
    end
  end
end
