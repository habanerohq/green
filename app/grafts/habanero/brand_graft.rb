module Habanero
  module BrandGraft
    extend ActiveSupport::Concern

    included do
      has_many :varieties, :class_name => '::Habanero::Variety', :dependent => :restrict

      validates :name,
                :presence => true,
                :uniqueness => true

      unloadable
    end

    def qualified_name
      name # todo: qualify as class name etc.
    end

    def germinate!
      unless germinated?
        Object.const_set(qualified_name, Module.new).tap do |klass|
          klass.unloadable
        end
      end

      Object.const_get(qualified_name)
    end

    def germinated?
      Object.constants.include?(qualified_name)
    end

    def klass
      qualified_name.constantize
    end
  end
end
