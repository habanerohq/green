module Habanero
  module SorbetIce
    extend ActiveSupport::Concern

    included do
      belongs_to :namespace, :class_name => '::Habanero::Namespace'
      has_many :ingredients,
               :class_name => '::Habanero::Ingredient',
               :inverse_of => :sorbet,
               :dependent => :destroy

      acts_as_nested_set

      scope :namespaced, lambda { |n| joins(:namespace).where('habanero_namespaces.name = ?', n) }

      validates :name,
                :presence => true,
                :uniqueness => { :scope => :namespace_id }

      validates_associated :ingredients

      before_create :create_table # failed create leaves empty table?
      after_destroy :remove_const

      unloadable
    end

    def qualified_name
      "#{namespace.qualified_name}::#{klass_name}"
    end

    def all_ingredients
      self_and_ancestors.includes(:ingredients).map(&:ingredients).flatten
    end

    def displayable_ingredients(ingreds)
      (ingreds || ingredients).reject { |i| i.type == 'Habanero::RelationIngredient'}
    end

    def all_displayable_ingredients
      displayable_ingredients(all_ingredients)
    end

    def table_name
      base.qualified_name.pluralize.attrify
    end

    def klass_name
      name
    end

    def chill!
      return klass if chilled?

      namespace.klass.const_set(klass_name, Class.new(parent.klass))
      klass.unloadable

      klass.class_attribute :_sorbet
      klass._sorbet = self
      klass.table_name = table_name

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

    def chilled?
      namespace.klass.constants.include?(klass_name)
    end

    def klass
      namespace.klass.const_get(klass_name)
    end

    def base
      if parent
        parent.self_and_ancestors.detect(&:parent)
      end || self
    end

    def adapt
      ingredients.each { |i| i.adapt(klass) }
    end

    protected

    def create_table
      if parent
#          puts "create_table #{table_name}" unless connection.table_exists?(table_name) # write this to a log!
        connection.create_table(table_name) unless connection.table_exists?(table_name)
      end
    end

    def remove_const
      namespace.klass.send(:remove_const, klass_name) if chilled?
    end
  end
end
