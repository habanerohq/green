module Habanero
  module IngredientIce
    extend ActiveSupport::Concern

    included do
      belongs_to :sorbet, :inverse_of => :ingredients

      acts_as_nested_set

      after_create :add_columns
      after_save :change_columns
      after_destroy :remove_columns

      # reset column information on the sorbet when necessary
      after_save :reset_columns
      after_destroy :reset_columns

      validates :name,
                :presence => true,
                :uniqueness => { :scope => 'sorbet_id' }

      unloadable
    end

    module InstanceMethods
      def qualified_name
        [parent.try(:qualified_name), name].compact.join('_').attrify
      end

      def adapt(klass)
        # nothing to do here yet
      end

      def column_name
        qualified_name
      end

      def method_name
        column_name
      end

      def column_type
        :string
      end

      def to_s
        name
      end

    protected

      def add_columns
        unless column_exists?(column_name)
          add_column column_name, column_type
        end

        adapt(sorbet.klass) if sorbet.chilled?
      end

      def column_exists?(column_name)
        connection.columns(sorbet.table_name).map(&:name).include?(column_name.to_s)
      end

      def add_column(name, type)
#        puts "add_column #{sorbet.table_name}, #{name}, #{type}" # write this to a log!
        connection.add_column sorbet.table_name, name, type
      end

      def change_columns
        if name_was and name_changed?
          rename_column(name_was.attrify, column_name)
        end
      end

      def rename_column(old_name, new_name)
#        puts "rename_column #{sorbet.table_name}, #{old_name}, #{new_name}" # write this to a log!
        connection.rename_column sorbet.table_name, old_name, new_name
      end

      def remove_columns
        remove_column(column_name)
      end

      def remove_column(name)
#        puts "remove_column #{name}" # write this to a log!
        connection.remove_column sorbet.table_name, name
      end

      def reset_columns
        sorbet.klass.reset_column_information unless parent
      end
    end
  end
end
