module Habanero
  module NumberIngredientGraft
    extend ActiveSupport::Concern

    def column_type
      :float
    end
  end
end
