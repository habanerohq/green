module Habanero
  module ScenesHelper
    def scene_path(scene, *args)
      options = args.extract_options!
      target = args.first
      params = (target ? {:variety_type => target.class._variety, :id => target} : {}).merge(options)
      
      if target and (ss = target.class._variety.try(:slug_scope))
        params[:scope_id] = target.send(ss.method_name)
      end
      
      send "scene_#{scene.id}_path", params
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
