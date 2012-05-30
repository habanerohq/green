module Habanero
  class ScenesController < ActionController::Base
    def show
      params.deep_blank_to_nulls!
      @scene = @routable = params[:draw_type].constantize.find(params[:draw_id])
      @scene.all_placements.each { |p|  p.prepare(params, @scene) }
      
      render :layout => @scene.layout_name
    end
  end
end
