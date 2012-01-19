module Habanero
  module NumberIngredientIce
    extend ActiveSupport::Concern
    
    module InstanceMethods
      def column_type
        :float
      end
    end
  end
end