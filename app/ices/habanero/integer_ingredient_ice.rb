module Habanero
  module IntegerIngredientIce
    extend ActiveSupport::Concern
    
    module InstanceMethods
      def column_type
        :integer
      end
    end
  end
end