module Habanero
  module MaskIngredientIce
    extend ActiveSupport::Concern

    module InstanceMethods
      def to_s
        "#{ingredient}"
      end
    end
  end
end
