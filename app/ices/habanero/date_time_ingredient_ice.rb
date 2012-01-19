module Habanero
  module DateTimeIngredientIce
    extend ActiveSupport::Concern
    
    module InstanceMethods
      def column_type
        :datetime
      end
    end
  end
end