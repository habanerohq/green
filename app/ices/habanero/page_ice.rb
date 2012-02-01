module Habanero
  module PageIce
    extend ActiveSupport::Concern

    included do
      alias_method :parent, :section
    end

    module InstanceMethods
      def draw_route(map)
        # todo: site.host should be optional
        map.match qualified_path => 'habanero/pages#show', :constraints => { :host => section.site.host }
      end
    end
  end
end
