module Habanero
  module PagesHelper
    def page_path(page, params = {})
      send "page_#{page.id}_path", params
      #url_for(params.merge :use_route => "page_#{page.id}")
    end
    
    def new_sorbet_page
      Habanero::ScoopPlacement.joins(:scoop, :page).where(:template => 'new', :habanero_scoops => {:type => 'Habanero::SorbetScoop'}).first.page
    end
  end
end
