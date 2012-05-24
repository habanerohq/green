module Habanero
  module SiteGraft
    extend ActiveSupport::Concern

    included do
      before_create :create_default_initial_objects
    end

    module ClassMethods
      def current
        @current ||= self.first # need to be able to configure this!
      end
    end
    
    def create_default_initial_objects
      Habanero::Brand.create(:name => name)

      g = Habanero::Garden.create(
        :name => "#{name} front",
        :signpost => '/front'
      )

      self.root_scene = Habanero::Scene.create(
        :name => 'Index',
        :signpost => '/',
        :garden => g,
        :layout => Habanero::Layout.find_by_name('Habanero')
      )
    end
  end
end
