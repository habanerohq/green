module Habanero
  module PageIce
    extend ActiveSupport::Concern

    included do
      validates :name,
                :presence => true,
                :uniqueness => { :scope => 'section_id' }
    end

    module ClassMethods
      def draw_routes(map)
        # respect order scoped by section when drawing page routes
        order('section_position').all.each { |p| p.draw_route(map) }
      end
    end

    def parent
      section
    end

    def draw_route(map, options = {})
      options[:constraints] = { :host => section.site.host } unless section.site.host.blank?
      options[:as] = "page_#{id}"
      options[:defaults] = { :draw_type => self.class.name, :draw_id => id }

      if sites.any?
        map.root({ :to => 'habanero/pages#show' }.merge(options))
      end

      map.match({ qualified_path => 'habanero/pages#show' }.merge(options))
    end

    def layout_name
      (layout.template_name || layout.name.attrify) if layout
    end

    def target_class
      nearest_target.try(:klass)
    end

    def nearest_target
      target || section.nearest_target
    end
  end
end
