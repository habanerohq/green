module Habanero
  module PlacementsHelper
    def arrange(scene)
      scene.all_placements.each do |p|
        content_for(p.region_name) { place(p) }
      end
    end

    def place(placement)
      render_cell(placement.feature.cell_type,
                  placement.template.present? ? placement.template : 'show',
                  :scene => @scene,
                  :placement => placement,
                  :target => @target
      )
    end
    
    def collection_title
      unless @placement.feature.title.blank?
        @placement.feature.title.blank?
      else
        "#{@variety.to_s} #{@placement.template}"
      end
    end
  end
end
