module Habanero
  module PagesHelper
    def page_path(page, params = {})
      send "page_#{page.id}_path", params
      #url_for(params.merge :use_route => "page_#{page.id}")
    end
  end
end
