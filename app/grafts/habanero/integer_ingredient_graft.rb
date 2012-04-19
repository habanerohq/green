module Habanero
  module IntegerIngredientGraft
    extend ActiveSupport::Concern

    def column_type
      :integer
    end
  end
end
