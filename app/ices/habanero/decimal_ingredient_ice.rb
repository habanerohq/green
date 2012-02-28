module Habanero
  module DecimalIngredientIce
    extend ActiveSupport::Concern

    def column_type
      :decimal
    end
  end
end
