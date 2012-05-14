module Habanero
  module GardenGraft
    extend ActiveSupport::Concern

    included do
      validates :name, :presence => true
    end    

    def nearest_target
      target || parent.try(:nearest_target)
    end

    def names_idified
      self_and_ancestors.map{ |a| a.name.idify }.join(' ')
    end
    
    def index_scene
      scene
    end
    
    def scene
      scenes.detect { |p| p.is_index_scene? }
    end
    
    def indexed_children
      children.select { |c| c.index_scene.present? }
    end
  end
end
