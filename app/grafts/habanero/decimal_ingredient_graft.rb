module Habanero
  module DecimalIngredientGraft
    extend ActiveSupport::Concern

    def column_type
      :decimal
    end
  end
end
