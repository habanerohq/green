module Habanero
  module PagesHelper
    def page_path(page, params = {})
      send "page_#{page.id}_path", params
      #url_for(params.merge :use_route => "page_#{page.id}")
    end
    
    def new_variety_page
      Habanero::Page.find_all_by_route('/:variety_type/new').detect { |p| p.garden.route? }
    end
    
    def target_pages(targets)
      targets.map do |t|
        case
        when t._variety.name == 'Page'
          t
        when t.respond_to?(:page)
          t.page
        end
      end.compact
    end
    
    def maybe_use_garden_if_index(target)
      target.name.downcase == 'index' ? target.garden : target 
    end
  end
end
