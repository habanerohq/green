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
        [parent.try(:qualified_name), name.attrify].compact.join('_')
      end

      def adapt(klass)
        # nothing to do here yet
      end

      def column_type
        :string
      end

    protected

      def add_columns
        unless connection.columns(sorbet.table_name).map(&:name).include?(qualified_name)
#          puts "add_column #{sorbet.table_name}, #{qualified_name}, #{column_type}" # write this to a log!
          connection.add_column sorbet.table_name, qualified_name, column_type
        end
      end

      def change_columns
        if name_was and name_changed?
#          puts "rename_column #{sorbet.table_name}, #{name_was.attrify}, #{qualified_name}" # write this to a log!
          connection.rename_column sorbet.table_name, name_was.attrify, qualified_name
        end
      end

      def remove_columns
#        puts "remove_column #{sorbet.table_name}, #{qualified_name}" # write this to a log!
        connection.remove_column sorbet.table_name, qualified_name
      end
    end
  end
end