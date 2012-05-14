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
    
    def subgardens(options)
      instance_variables_from(options)
      @index_scenes = @scene.garden.siblings.map { |s| s.index_scene }.compact
      render
    end
    
    def siblings(options)
      instance_variables_from(options)
      @scenes = @scene.garden.scenes
      render
    end
  end
end
