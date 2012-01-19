module Habanero
  module DateIngredientIce
    extend ActiveSupport::Concern
    
    module InstanceMethods
      def column_type
        :date
      end
    end
  end
end