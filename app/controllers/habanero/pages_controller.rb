module Habanero
  class PagesController < ActionController::Base
    def show
      render :text => params.inspect
    end
  end
end
