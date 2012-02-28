module Habanero
  module PercentageIngredientIce
    extend ActiveSupport::Concern

    def column_type
      :float
    end
  end
end
