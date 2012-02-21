module Habanero
  module SlugIngredientIce
    extend ActiveSupport::Concern

    included do
      after_create :add_indices
      after_save :change_indices
      after_destroy :remove_indices
    end
    
    module InstanceMethods
      def column_name
        :slug
      end

      def adapt(klass)
        klass.send :extend, FriendlyId
        options = if scope.present?
          { :use => :scoped, :scope => scope.column_name }
        else
          { :use => :slugged }
        end
        klass.friendly_id target.method_name, options
      end

    protected

      def add_indices
        unless column_exists?(column_name)
          add_index column_name
        end
      end

      def add_index(name)
        options = scope.blank? ? { :unique => true } : {}
        connection.add_index sorbet.table_name, name, options
      end

      def change_indices
        if name_was and name_changed?
          rename_index(name_was.attrify, column_name)
        end
      end

      def rename_index(old_name, new_name)
        connection.rename_index sorbet.table_name, old_name, new_name
      end

      def remove_indices
        remove_index(column_name)
      end

      def remove_index(name)
        connection.remove_column sorbet.table_name, name
      end
    end
  end
end
