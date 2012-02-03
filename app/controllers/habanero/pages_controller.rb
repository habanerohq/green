module Habanero
  class PagesController < ActionController::Base
    def show
      @page = @routable = params[:draw_type].constantize.find(params[:draw_id])
      @target = @page.target_class.find(params[:id]) if params[:id]
      render :layout => @page.layout.try(:name).try(:attrify) || 'habanero'
    end
  end
end
