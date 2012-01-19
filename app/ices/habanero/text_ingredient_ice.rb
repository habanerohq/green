module Habanero
  module TextIngredientIce
    extend ActiveSupport::Concern
    
    module InstanceMethods
      def column_type
        :text
      end
    end
  end
end