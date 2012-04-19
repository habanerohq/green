module Habanero
  class NavigationCell < Habanero::AbstractCell
    include Habanero::PagesHelper
  
    def site(options)
      instance_variables_from(options)
      @gardens = Habanero::Garden.indexed_roots
      render
    end
    
    def subgardens(options)
      instance_variables_from(options)
      @index_pages = @page.garden.siblings.map { |s| s.index_page }.compact
      render
    end
    
    def siblings(options)
      instance_variables_from(options)
      @pages = @page.garden.pages
      render
    end
  end
end
