module Habanero
  class NavigationCell < Habanero::AbstractCell
    include Habanero::ScenesHelper
  
    def site(options)
      instance_variables_from(options)
      @gardens = if (s = Habanero::Site.current).present?
        s.gardens.map(&:garden)
      else
        []
      end    

      render
    end
    
    def around_here(options)
      instance_variables_from(options)
      @scenes = @scene.garden.scenes
      render
    end
    
    def near_signpost(options)
      instance_variables_from(options)
      @index_scenes = @scene.garden.siblings.map { |s| s.index_scene }.compact
      render
    end
    
    def previous_signpost(options)
      instance_variables_from(options)
      g = @scene.garden.ancestors.try(:first) || @scene.garden
      @index_scenes = g.siblings.map { |s| s.index_scene }.compact
      render
    end
  end
end
