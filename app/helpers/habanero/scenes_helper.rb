module Habanero
  module ScenesHelper
    def scene_path(scene, params = {})
      send "scene_#{scene.id}_path", params
      #url_for(params.merge :use_signpost => "scene_#{scene.id}")
    end
    
    def new_variety_scene
      Habanero::Scene.find_all_by_signpost('/:variety_type/new').detect { |p| p.garden.signpost? }
    end
    
    def target_scenes(targets)
      targets.map do |t|
        case
        when t._variety.name == 'Scene'
          t
        when t.respond_to?(:scene)
          t.scene
        end
      end.compact
    end
    
    def maybe_use_garden_if_index(target)
      target.name.downcase == 'index' ? target.garden : target 
    end
  end
end
