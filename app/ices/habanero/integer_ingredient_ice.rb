module Habanero
  module IntegerIngredientIce
    extend ActiveSupport::Concern

    def column_type
      :integer
    end
  end
end
