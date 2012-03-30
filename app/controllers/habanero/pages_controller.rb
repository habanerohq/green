module Habanero
  class PagesController < ActionController::Base
    def show
      @page = @routable = params[:draw_type].constantize.find(params[:draw_id])
      @page.all_placements.each { |p|  p.prepare(params, @page) }
      
      render :layout => @page.layout_name
    end
  end
end
