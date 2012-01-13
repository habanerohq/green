module Habanero
  module SorbetIce
    extend ActiveSupport::Concern

    included do
      belongs_to :namespace
      validates :namespace, :presence => true

      acts_as_nested_set

      has_many :ingredients, :class_name => 'Habanero::Ingredient'

      validates :name, :uniqueness => { :scope => :namespace_id }

      before_create :mix! # failed create leaves empty table?
      # --- table
      # create
        # before_create
        # create
        # after_create
      after_create :chill!
    end

    module InstanceMethods
      def qualified_name
        "#{namespace.qualified_name}::#{name}" # todo: qualify name into class name
      end

      def table_name
        base.qualified_name.pluralize.underscore.gsub('/', '_')
      end

      def mix!
        if parent
          connection.create_table(table_name) unless connection.table_exists?(table_name)
        end
      end

      def chill!
        if parent # don't redefine edge classes ;)
          begin
            namespace.klass.send :remove_const, name
          rescue NameError
          end

          parent.chill!
          namespace.klass.const_set(name, Class.new(parent.klass))

          begin
            klass.send :include, "#{qualified_name}Ice".constantize
          rescue NameError => e
          end
        end
      end

      def klass
        begin
          qualified_name.constantize
        rescue NameError => e
          chill!
        end

        qualified_name.constantize
      end
      
      def base
        if parent
          parent.self_and_ancestors.detect(&:parent)
        end || self
      end
    end
  end
end