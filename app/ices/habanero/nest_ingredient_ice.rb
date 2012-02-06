module Habanero
  module NestIngredientIce
    extend ActiveSupport::Concern
    
    module InstanceMethods
      
      def column_names
        [:parent_id, :lft, :rgt]
      end
      
      def column_type
        :integer
      end

      def adapt(klass)
        klass.send :acts_as_nested_set if klass.respond_to?(:acts_as_nested_set_options)
      end

    protected

      def add_columns
        unless column_exists?(column_names.first.to_s)
          column_names.each { |c| add_column c, column_type }
        end
      end

      def change_columns
      end

      def remove_columns
        column_names.each { |c| remove_column c }
      end
    end
  end
end