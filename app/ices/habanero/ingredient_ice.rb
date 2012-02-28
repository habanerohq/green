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

    protected

      [:add_column, :remove_column, :rename_column, :'column_exists?',
       :add_index, :remove_index, :rename_index, :'index_exists?'].each do |msg|
        class_eval <<-RUBY_EVAL
          def #{msg}(*args)
            args.unshift(sorbet.table_name)
            connection.send(:#{msg}, *args)
          end
        RUBY_EVAL
      end

      def add_columns
        unless column_exists?(column_name)
          add_column column_name, column_type
        end

        adapt(sorbet.klass) if sorbet.chilled?
      end

      def change_columns
        if name_was and name_changed?
          rename_column(name_was.attrify, column_name)
        end
      end

      def remove_columns
        remove_column(column_name)
      end

      def reset_columns
        sorbet.klass.reset_column_information unless parent
      end
    end
  end
end
