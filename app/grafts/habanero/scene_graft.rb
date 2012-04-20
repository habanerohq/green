module Habanero
  module SceneGraft
    extend ActiveSupport::Concern

    included do
      validates :name,
                :presence => true,
                :uniqueness => { :scope => 'garden_id' }
    end

    module ClassMethods
      def label_signposts(map)
        where('signpost is not null').order('garden_position').reject { |p| p.signpost.blank? or p.garden.try(:signpost).blank? }.each { |p| p.label_signpost(map) }
      end
    end

    def parent
      garden
    end

    def label_signpost(map, options = {})
      options[:constraints] = { :host => garden.site.host } unless garden.site.host.blank?
      options[:as] = "scene_#{id}"
      options[:defaults] = { :draw_type => self.class.name, :draw_id => id }

      if sites.any?
        map.root({ :to => 'habanero/scenes#show' }.merge(options))
      end

      map.match({ qualified_path => 'habanero/scenes#show' }.merge(options))
    end
    
    def all_placements
      inherited_placements + placements
    end
    
    def inherited_placements
      template.try(:all_placements) || []
    end

    def layout_name
      (layout.template_name || layout.name.attrify) if layout
    end

    def target_class
      nearest_target.try(:klass)
    end

    def nearest_target
      target || garden.nearest_target
    end
    
    def is_index_scene?
      signpost.in? ['/', '/index'] or name.downcase == 'index'
    end
    
    def to_s_qual
      "#{name} (#{garden})"
    end    
  end
end
