module Habanero
  module RelationIngredientIce
    extend ActiveSupport::Concern
    
    included do
      validates :relation,
                :presence => true,
                :inclusion => { :in => %w(belongs_to has_one has_many has_and_belongs_to_many) }
    end

    module InstanceMethods
      def adapt(klass)
        klass.send relation, qualified_name
      end

      def column_name
        "#{qualified_name}_id"
      end

      protected

      def add_columns
        unless connection.columns(sorbet.table_name).map(&:name).include?(column_name)
          if relation == 'belongs_to'
            connection.add_column sorbet.table_name, column_name, :integer
          end
        end
      end

      def change_columns
        if name_was and name_changed?
          connection.rename_column sorbet.table_name, "#{name_was.attrify}_id", column_name
        end
      end

      def remove_columns
        connection.remove_column sorbet.table_name, column_name
      end
    end
  end
end