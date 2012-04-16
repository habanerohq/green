module Habanero
  module SectionIce
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
    
    def page
      pages.detect { |p| p.route.in? ['/', '/index'] or p.name.downcase == 'index' }
    end
  end
end
