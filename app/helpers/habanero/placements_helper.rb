module Habanero
  module PlacementsHelper
    def arrange(page)
      page.placements.each do |p|
        content_for(p.region_name) { place(p) } 
      end 
    end

    def place(placement)
      render_cell(placement.scoop.cell_type, placement.template, 
        :page => @page, 
        :placement => placement,
        :target => @target
      )
    end

    def arrangement_for(region_name)
      content_tag(:div, content_for(region_name.to_sym), :class => "region #{region_name.to_s.idify}")
    end
  end
end