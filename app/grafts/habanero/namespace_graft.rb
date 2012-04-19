module Habanero
  module NamespaceGraft
    extend ActiveSupport::Concern

    included do
      has_many :sorbets, :class_name => '::Habanero::Sorbet', :dependent => :restrict

      validates :name,
                :presence => true,
                :uniqueness => true

      unloadable
    end

    def qualified_name
      name # todo: qualify as class name etc.
    end

    def chill!
      unless chilled?
        Object.const_set(qualified_name, Module.new).tap do |klass|
          klass.unloadable
        end
      end

      Object.const_get(qualified_name)
    end

    def chilled?
      Object.constants.include?(qualified_name)
    end

    def klass
      qualified_name.constantize
    end
  end
end
