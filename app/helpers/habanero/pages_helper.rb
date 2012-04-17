module Habanero
  module PagesHelper
    def page_path(page, params = {})
      send "page_#{page.id}_path", params
      #url_for(params.merge :use_route => "page_#{page.id}")
    end
    
    def new_sorbet_page
      Habanero::Page.find_by_route('/:sorbet_type/new')
    end
    
    def target_pages(targets)
      targets.map do |t|
        case
        when t._sorbet.name == 'Page'
          t
        when t.respond_to?(:page)
          t.page
        end
      end.compact
    end
    
    def maybe_use_section_if_index(target)
      target.name.downcase == 'index' ? target.section : target 
    end
  end
end
