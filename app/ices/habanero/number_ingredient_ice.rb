module Habanero
  module NumberIngredientIce
    extend ActiveSupport::Concern

    def column_type
      :float
    end
  end
end
