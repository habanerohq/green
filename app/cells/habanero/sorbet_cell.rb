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

      if request.put? && data = params[:"placement_#{@placement.id}"]
        @target.update_attributes(data)
        parent_controller.redirect_to page_path(@placement.scoop.page || @page, :id => @target, :sorbet_type => @target._sorbet)
      end

      render
    end

    def new(options)
      instance_variables_from(options)

      @sorbet = Habanero::Sorbet.find(params[:sorbet_type])
      @target = @sorbet.klass.new(params[:"placement_#{@placement.id}"])
      @ingredients = @placement.scoop.mask ? @placement.scoop.mask.mask_ingredients.map(&:ingredient) : @target._sorbet.all_displayable_ingredients

      if data = params[:"placement_#{@placement.id}"] and request.method =~ /POST/i
        # here we would update, maybe create if PUT works
        if @target.save
          parent_controller.redirect_to page_path(@placement.scoop.page || @page, :id => @target, :sorbet_type => @target._sorbet)
        end
      end

      render
    end
  end
end
