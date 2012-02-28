module Habanero
  module SlugIngredientIce
    extend ActiveSupport::Concern

    included do
      validate :validate_scope, :if => :scoped?

      after_create :add_index
      after_save :change_index
      after_destroy :remove_index
    end

    def column_name
      :slug
    end

    def adapt(klass)
      klass.send :extend, FriendlyId
      options = if scoped?
        { :use => :scoped, :scope => scope.column_name }
      else
        { :use => :slugged }
      end
      klass.friendly_id target.method_name, options
    end

    def scoped?
      scope.present?
    end

    def unscoped?
      scoped? == false
    end

    protected

    def validate_scope
      errors.add(:scope, "is not present on the target sorbet") unless scope.sorbet == target.sorbet
      errors.add(:scope, "is not a belongs_to association") if scope.relation != 'belongs_to'
    end

    def add_index
      connection.add_index(sorbet.table_name, column_name, :unique => unscoped?)
    end

    def change_index
      if name_changed? && name_was.present?
        connection.rename_index(sorbet.table_name, name_was.attrify, column_name)
      end

      if scope_id_changed?
        connection.remove_index(sorbet.table_name, column_name) if connection.index_exists?(sorbet.table_name, column_name)
        connection.add_index(sorbet.table_name, column_name, :unique => unscoped?)
      end
    end

    def remove_index
      connection.remove_index(sorbet.table_name, column_name) if connection.index_exists?(sorbet.table_name, column_name)
    end
  end
end
