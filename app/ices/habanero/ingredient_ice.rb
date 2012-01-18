module Habanero
  module IngredientIce
    extend ActiveSupport::Concern

    included do
      belongs_to :sorbet

      acts_as_nested_set

      after_create :add_columns
      after_save :change_columns
      after_destroy :remove_columns

      validates :name,
                :presence => true,
                :uniqueness => { :scope => 'sorbet_id' }

      Sorbet.namespaced('Habanero').where(:name => 'Ingredient').first.try(:adapt)
    end

    module InstanceMethods
      def qualified_name
        name.attrify
      end

      def adapt(klass)
        # nothing to do here yet
      end

    protected

      def add_columns
        unless connection.columns(sorbet.table_name).map(&:name).include?(qualified_name)
          connection.add_column sorbet.table_name, qualified_name, :string
        end
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