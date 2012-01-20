module Habanero
  module PercentageIngredientIce
    extend ActiveSupport::Concern
    
    module InstanceMethods
      def column_type
        :float
      end
    end
  end
end