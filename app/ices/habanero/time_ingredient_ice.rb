module Habanero
  module TimeIngredientIce
    extend ActiveSupport::Concern
    
    module InstanceMethods
      def column_type
        :time
      end
    end
  end
end