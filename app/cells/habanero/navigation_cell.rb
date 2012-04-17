module Habanero
  class NavigationCell < Habanero::AbstractCell
    include Habanero::PagesHelper
  
    def site(options)
      instance_variables_from(options)
      @sections = Habanero::Section.indexed_roots
      render
    end
    
    def subsections(options)
      instance_variables_from(options)
      @index_pages = @page.section.siblings.map { |s| s.index_page }.compact
      render
    end
    
    def siblings(options)
      instance_variables_from(options)
      @pages = @page.section.pages
      render
    end
  end
end
