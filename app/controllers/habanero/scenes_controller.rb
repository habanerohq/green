module Habanero
  class ScenesController < ActionController::Base
    def show
      params.deep_blank_to_nulls!
      @scene = @routable = params[:draw_type].constantize.find(params[:draw_id])
      @scene.all_placements.each { |p|  p.prepare(params, @scene) }
      
      snaffle_session
      
      render :layout => @scene.layout_name
    end
    
    protected
    
    def snaffle_session
      if vt = params[:variety_type] and v = params[:id]
        session[vt] = Habanero::Variety.find(vt).klass.find(v).id
      end
    end
  end
end
