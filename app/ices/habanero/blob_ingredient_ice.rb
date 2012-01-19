module Habanero
  module BlobIngredientIce
    extend ActiveSupport::Concern
    
    module InstanceMethods
      def column_type
        :binary
      end
    end
  end
end