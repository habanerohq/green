module Habanero
  class VarietyCell < Habanero::AbstractCell
    include Habanero::ScenesHelper

    def siblings(options)
      get_started(options)
      @target = find_target
      @sibling_trait = @traits.first
      @targets = if @sibling_trait.relation == 'belongs_to'
        @target.send(@sibling_trait.method_name).send(@sibling_trait.inverse_method_name) - [@target]
      else
        []
      end
      render 
    end

    def paragraphs(options)
      get_started(options)
      @target = find_target
      render
    end

    def show(options)
      get_started(options)
      @target = find_target
      render
    end

    def edit(options)
      get_started(options)
      @target = find_target

      case
      when request.delete?
        if @target.destroy
          # todo: redirect somewhere
        end
      when params[@placement.params_key] && request.put?
        @target.update_attributes(params[@placement.params_key])
        yield if block_given?
        redirect_to scene_path(next_scene, @target)
      end

      render
    end

    def new(options)
      get_started(options)

      unless params[@placement.params_key] && request.post?
        @target = @variety.klass.new(params[:context])
        maybe_populate_target_from_session
      else  
        @target = @variety.klass.new(params[@placement.params_key])
        @target.transaction do
          if @target.save
            @target.post_create if @target.respond_to?(:post_create)
            yield if block_given?
            redirect_to scene_path(next_scene, @target)
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
          @variety.klass.joins(ss.method_name.to_sym).readonly(false).where(:slug => params[:id], scope_klass.table_name => {:slug => params[:scope_id]}).first
        else
          @variety.klass.find(params[:id])
        end
      end
    end
    
    def maybe_populate_target_from_session
      @traits.select { |t| t.relation == 'belongs_to' }.each do |t|
        @target.send("#{t.column_name}=", session[t.name.downcase]) if session[t.name.downcase].present?
      end
    end 
    
    def next_scene
      @feature.scene || @variety.scene
    end 
  end
end
