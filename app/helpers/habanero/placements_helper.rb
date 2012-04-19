module Habanero
  module PlacementsHelper
    def arrange(page)
      page.all_placements.each do |p|
        content_for(p.region_name) { place(p) }
      end
    end

    def place(placement)
      render_cell(placement.scoop.cell_type,
                  placement.template.present? ? placement.template : 'show',
                  :page => @page,
                  :placement => placement,
                  :target => @target
      )
    end
    
    def collection_title
      unless @placement.scoop.title.blank?
        @placement.scoop.title.blank?
      else
        "#{@variety.to_s} #{@placement.template}"
      end
    end
  end
end
