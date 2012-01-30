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

      scope :namespaced, lambda { |n| includes(:namespace).where('habanero_namespaces.name = ?', n) }

      self.namespaced('Habanero').where(:name => 'Sorbet').first.try(:adapt)
    end

    module InstanceMethods
      def qualified_name
        "#{namespace.qualified_name}::#{name}" # todo: qualify name into class name
      end

      def table_name
        base.qualified_name.pluralize.attrify
      end

      def mix!
        if parent
          connection.create_table(table_name) unless connection.table_exists?(table_name)
        end
      end

      def chill!
        if parent # don't redefine edge classes ;)
          namespace.klass.const_set(name, Class.new(parent.klass))

          klass.reset_column_information
          adapt

          begin
            # fixme: syntax errors (at least) in the ice are ignored and results in failing
            #        to include the ice at all, silently
            klass.send :include, "#{qualified_name}Ice".constantize
          rescue NoMethodError then raise
          rescue NameError
          end

          klass
        end
      end

      def klass
        qualified_name.constantize
      end

      def base
        if parent
          parent.self_and_ancestors.detect(&:parent)
        end || self
      end

      def all_ingredients
        self_and_ancestors.includes(:ingredients).map(&:ingredients).flatten
      end

      def adapt
        ingredients.each { |i| i.adapt(klass) }
      end
    end
  end
end
