module Habanero
  module NamespaceIce
    extend ActiveSupport::Concern

    included do
      has_many :sorbets

      validates :name, :uniqueness => true
    end

    module InstanceMethods
      def qualified_name
        name # todo: qualify as class name etc.
      end

      def chill!
        Object.const_set(qualified_name, Module.new)
      end

      def klass
        qualified_name.constantize
      end

      def to_s
        name
      end
    end
  end
end
