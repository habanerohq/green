module Habanero
  module CurrencyIngredientIce
    extend ActiveSupport::Concern
    
    module InstanceMethods
      def column_type
        :decimal
      end
    end
  end
end