module Habanero
  class VarietyCell < Habanero::AbstractCell
    include Habanero::ScenesHelper

    def show(options)
      get_started(options)
      @target = find_target
      render
    end

    def edit(options)
      get_started(options)
      @target = find_target

      if request.delete?
        if @target.destroy
          # todo: redirect somewhere
        end
      end

      if params[@placement.params_key] && request.put?
        @target.update_attributes(params[@placement.params_key])
        redirect_to scene_path(@placement.feature.scene || @scene, @target)
      end

      render
    end

    def new(options)
      get_started(options)
      @target = @variety.klass.new(params[@placement.params_key])

      if params[@placement.params_key] && request.post?
        @target.transaction do
          if @target.save
            @target.post_create if @target.respond_to?(:post_create)
            redirect_to scene_path(@placement.feature.scene || @scene, @target)
          end
        end
      end

      render
    end
    
    def connections(options)
      instance_variables_from(options)
      @variety = Habanero::Variety.find(params[:variety_type])
      @traits = @variety.connections
      @target = find_target
      
      render
    end
    
    protected
    
    def get_started(options)
      instance_variables_from(options)
      @variety = Habanero::Variety.find(params[:variety_type])
      @traits = @placement.traits || @variety.primary_traits
    end
    
    def find_target
      if params[:id]
        if params[:scope_id] and (ss = @variety.slug_scope)
          scope_klass = ss.inverse_variety.klass
          @variety.klass.joins(ss.method_name.to_sym).where(:slug => params[:id], scope_klass.table_name => {:slug => params[:scope_id]}).first
        else
          @variety.klass.find(params[:id])
        end
      end
    end
  end
end
