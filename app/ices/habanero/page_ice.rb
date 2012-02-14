module Habanero
  module PageIce
    extend ActiveSupport::Concern

    included do
      alias_method :parent, :section
    end

    module InstanceMethods
      def draw_route(map, options = {})
        options[:constraints] = { :host => section.site.host } if section.site.host
        map.match ({ qualified_path => 'habanero/pages#show', :defaults => { :draw_type => self.class.name, :draw_id => id } }).merge(options)
      end
      
      def target_class
        nearest_target.try(:klass)
      end
      
      def nearest_target
        target || section.nearest_target
      end
    end
  end
end
