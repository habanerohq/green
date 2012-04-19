module Habanero
  module CurrencyIngredientGraft
    extend ActiveSupport::Concern

    def column_type
      :decimal
    end
  end
end
