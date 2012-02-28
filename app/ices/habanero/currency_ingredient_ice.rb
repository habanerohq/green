module Habanero
  module CurrencyIngredientIce
    extend ActiveSupport::Concern

    def column_type
      :decimal
    end
  end
end
