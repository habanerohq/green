module Habanero
  module PlacementsHelper
    def arrange(scene)
      scene.all_placements.each do |p|
        content_for(p.bed_name) { place(p) }
      end
    end

    def place(placement)
#      begin
        render_cell(placement.feature.cell_type,
                    placement.template.present? ? placement.template : 'show',
                    :scene => @scene,
                    :placement => placement,
                    :feature => placement.feature,
                    :target => @target
        )
#      rescue
#        render 'placement_error', {:placement => placement}
#      end
    end
    
    def collection_title
      case
      when @placement.feature.title.present?
        @placement.feature.title
      when !@scene.signpost.include?(':variety')
        @placement.feature.name
      else
        "#{@variety.to_s} #{@placement.template}"
      end
    end
  end
end
