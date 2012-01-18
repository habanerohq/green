module Habanero
  module TrueFalseIngredientIce
    extend ActiveSupport::Concern
    
    module InstanceMethods
      protected
      
      def add_columns
        unless connection.columns(sorbet.table_name).map(&:name).include?(qualified_name)
          connection.add_column sorbet.table_name, qualified_name, :boolean
        end
      end
    end
  end
end