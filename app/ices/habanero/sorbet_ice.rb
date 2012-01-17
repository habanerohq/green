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
      #after_create :chill!
      
      scope :namespaced, lambda { |n| includes(:namespace).where('habanero_namespaces.name = ?', n) }
      
      self.namespaced('Habanero').where(:name => 'Sorbet').first.try(:adapt)
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
          namespace.klass.const_set(name, Class.new(parent.klass)) # defining the class

          klass.reset_column_information
          ingredients.each { |i| i.adapt(klass) }

          begin
            klass.send :include, "#{qualified_name}Ice".constantize
          rescue NameError => e
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
        ingredients.each { |i| i.try(:adapt, klass) } # adapthibng the class
      end
    end
  end
end