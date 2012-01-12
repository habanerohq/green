module Habanero
  module IngredientIce
    extend ActiveSupport::Concern

    included do
      belongs_to :sorbet
      validates :sorbet, :presence => true

      after_create :add_columns
      after_save :change_columns
      after_destroy :remove_columns
    end

    module InstanceMethods
      def qualified_name
        name.attrify
      end

    protected

      def add_columns
        connection.add_column sorbet.table_name, qualified_name, :string
      end

      def change_columns
        if name_was and name_changed?
          connection.rename_column sorbet.table_name, name_was.attrify, qualified_name
        end
      end

      def remove_columns
        connection.remove_column sorbet.table_name, qualified_name
      end
    end
  end
end