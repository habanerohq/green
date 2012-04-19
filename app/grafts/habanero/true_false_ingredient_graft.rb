module Habanero
  module TrueFalseIngredientGraft
    extend ActiveSupport::Concern

    def column_type
      :boolean
    end
  end
end
