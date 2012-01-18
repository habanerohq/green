module Habanero
  module AssociationIngredientIce
    extend ActiveSupport::Concern

    included do
      validates :relation,
                :presence => true,
                :inclusion => { :in => %w(belongs_to has_one has_many has_and_belongs_to_many) }
    end

    module InstanceMethods
      def adapt(klass)
        options = { :class_name => inverse.sorbet.qualified_name }
        options.merge!(:order => "#{inverse.qualified_name}_position") if parent.ordered? and relation =~ /many/

        klass.send relation, qualified_name, options

        if parent.ordered? and relation == 'belongs_to'
          klass.send :acts_as_list, :scope => qualified_name, :column_name => "#{qualified_name}_position"
        end
      end
      
      def inverse
        siblings.first
      end

      def column_name
        "#{qualified_name}_id"
      end
      
      def columns_required?
        relation == 'belongs_to'
      end

      protected

      def add_columns
        if columns_required?
          unless connection.columns(sorbet.table_name).map(&:name).include?(column_name)
            connection.add_column sorbet.table_name, column_name, :integer
          end
          
          if parent.ordered?
            position_column = "#{qualified_name}_position"
            unless connection.columns(sorbet.table_name).map(&:name).include?(position_column)
              connection.add_column sorbet.table_name, position_column, :integer
            end
          end
        end
      end

      def change_columns
        if columns_required? and name_was and name_changed?
          connection.rename_column sorbet.table_name, "#{name_was.attrify}_id", column_name
        end
      end

      def remove_columns
        connection.remove_column sorbet.table_name, column_name if columns_required?
      end
    end
  end
end