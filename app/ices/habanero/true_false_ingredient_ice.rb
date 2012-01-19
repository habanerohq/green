module Habanero
  module TrueFalseIngredientIce
    extend ActiveSupport::Concern
    
    module InstanceMethods
      def column_type
        :boolean
      end
    end
  end
end