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
        options.merge!(:order => inverse.position_name) if parent.ordered? and relation =~ /many/

        klass.send relation, name.attrify, options

        if parent.ordered? and relation == 'belongs_to'
          klass.send :acts_as_list, :scope => name.attrify, :column_name => position_name
        end
      end
      
      def inverse
        siblings.first
      end
      
      def columns_required?
        relation =~ /belongs_to/
      end

      def column_name
        "#{name.attrify}_id"
      end

      def position_name
        "#{name.attrify}_position"
      end

      def column_type
        :integer
      end

      protected

      def add_columns
        if columns_required?
          unless column_exists?(column_name)
            add_column column_name, column_type
          end
          
          if parent.ordered?
            unless column_exists?(position_name)
              add_column position_name, column_type
            end
          end
        end
      end

      def change_columns
        if columns_required? and name_was and name_changed?
          rename_column "#{name_was.attrify}_id", column_name
        end
      end

      def remove_columns
        remove_column(column_name) if columns_required?
      end
    end
  end
end