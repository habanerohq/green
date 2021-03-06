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
        candidates = where('signpost is not null').order('garden_position').reject { |c| c.signpost.blank? or c.garden.try(:signpost).blank? }
        
        candidates.each do |c| 
          if c.sites.any?
            map.root({ :to => 'habanero/scenes#show' }.merge(c.signpost_options))
          end

          map.match({ c.qualified_path => 'habanero/scenes#show' }.merge(c.signpost_options))
        end
        
        candidates.select { |c| c.signpost =~ /:variety_type/ }.each do |c| 
          map.match(
            { c.qualified_path.gsub(':variety_type', ':scope_id/:variety_type') => 'habanero/scenes#show' }.
            merge(c.signpost_options).
            merge(:as => "scoped_scene_#{c.id}"))
        end
      end
    end

    def parent
      garden
    end

    def signpost_options(options = {})
      options[:constraints] = { :host => Habanero::Site.current.host } unless Habanero::Site.current.blank? or Rails.env.development?
      options[:as] = "scene_#{id}"
      options[:defaults] = { :draw_type => self.class.name, :draw_id => id }
      options
    end
    
    def all_placements
      inherited_placements + placements
    end
    
    def inherited_placements
      template.try(:all_placements) || []
    end
    
    def inherited_placement?(placement)
      !placements.include?(placement)
    end

    def layout_name
      (nearest_layout.template_name || nearest_layout.name.attrify) if nearest_layout
    end

    def nearest_layout
      layout || template.try(:nearest_layout)
    end

    def target_class
      nearest_target.try(:klass)
    end

    def nearest_target
      target || garden.nearest_target
    end

    def nearest_theme
      theme || garden.nearest_theme
    end
    
    def is_index_scene?
      signpost.in? ['/', '/index'] or name.downcase == 'index'
    end
    
    def edit_scene
      self.class.where(:signpost => "#{signpost}/edit").first
    end
    
    def to_s_qual
      "#{name} (#{garden})"
    end    
  end
end
