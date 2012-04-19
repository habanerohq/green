module Habanero
  class VarietyCell < Habanero::AbstractCell
    include Habanero::PagesHelper

    def show(options)
      _get_started(options)
      @target = @variety.klass.find(params[:id])
      render
    end

    def edit(options)
      _get_started(options)
      @target = @variety.klass.find(params[:id])

      if request.delete?
        if @target.destroy
          # todo: redirect somewhere
        end
      end

      if params[@placement.params_key] && request.put?
        @target.update_attributes(params[@placement.params_key])
        redirect_to page_path(@placement.scoop.page || @page, :id => @target, :variety_type => @target._variety)
      end

      render
    end

    def new(options)
      _get_started(options)
      @target = @variety.klass.new(params[@placement.params_key])

      if params[@placement.params_key] && request.post?
        @target.transaction do
          if @target.save
            @target.post_create if @target.respond_to?(:post_create)
            redirect_to page_path(@placement.scoop.page || @page, :id => @target, :variety_type => @target._variety)
          end
        end
      end

      render
    end
    
    def connections(options)
      instance_variables_from(options)
      @variety = Habanero::Variety.find(params[:variety_type])
      @traits = @variety.connections
      @target = @variety.klass.find(params[:id]) if params[:id]
      
      render
    end
    
    protected
    
    def _get_started(options)
      instance_variables_from(options)
      @variety = Habanero::Variety.find(params[:variety_type])
      @traits = @placement.traits || @variety.primary_traits
    end
  end
end
