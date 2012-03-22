module Habanero
  module PlacementsHelper
    def arrange(page)
      page.placements.each do |p|
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
  end
end
