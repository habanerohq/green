module Habanero
  module PagesHelper
    def page_path(page, params = {})
      url_for(params.merge :use_route => "page_#{page.id}")
    end
  end
end
