module Habanero
  module DecimalIngredientIce
    extend ActiveSupport::Concern
    
    module InstanceMethods
      def column_type
        :decimal
      end
    end
  end
end