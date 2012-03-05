module Habanero
  module SlugIngredientIce
    extend ActiveSupport::Concern

    included do
#      validate :slug_ingredient_validate_scope, :if => :scoped?

      # todo: there should be a nice way to wrap these in a class/module
      after_create  :slug_ingredient_after_create
      after_save    :slug_ingredient_after_save
      after_destroy :slug_ingredient_after_destroy
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

    def slug_ingredient_validate_scope
      errors.add(:scope, "is not present on the target sorbet") unless scope.sorbet == target.sorbet
      errors.add(:scope, "is not a belongs_to association") if scope.relation != 'belongs_to'
    end

    def slug_ingredient_after_create
      add_index(column_name, :unique => unscoped?)
    end

    def slug_ingredient_after_save
      if name_changed? && name_was.present?
        rename_index(name_was.attrify, column_name)
      end

      if scope_id_changed?
        remove_index(column_name) if index_exists?(column_name)
        add_index(column_name, :unique => unscoped?)
      end
    end

    def slug_ingredient_after_destroy
      # todo: is this necessary? the column should have already been removed by
      #       superclass, the index along with it
      remove_index(column_name) if index_exists?(column_name)
    end
  end
end
