module Habanero
  class ScenesController < ActionController::Base
    def show
      params.deep_blank_to_nulls!
      @scene = @routable = params[:draw_type].constantize.find(params[:draw_id])
      @scene.all_placements.each { |p|  p.prepare(params, @scene) }
      
      snaffle_session
      
      render :layout => @scene.layout_name
    end

    def sort
      context_klass = params[:variety_type].constantize
      context = context_klass.find(params[:id])
      trait = context_klass._variety.traits.find_by_name(params[:relation])

      params[trait.inverse_klass.name.underscore.pluralize].each_with_index do |oid, i|
        o = trait.inverse_klass.find(oid)
        o.send("#{trait.inverse_position_name}=", i + 1)
        o.send("#{trait.inverse_method_name}=", context)
        o.save!
      end

      render :nothing => true
    end
    
    protected
    
    def snaffle_session
      if vt = params[:variety_type] and v = params[:id]
        begin
          session[vt] = Habanero::Variety.find(vt).klass.find(v).id
        rescue ActiveRecord::RecordNotFound
        end
      end
    end
  end
end
