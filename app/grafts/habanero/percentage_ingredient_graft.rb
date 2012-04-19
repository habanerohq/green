module Habanero
  module PercentageIngredientGraft
    extend ActiveSupport::Concern

    def column_type
      :float
    end
  end
end
