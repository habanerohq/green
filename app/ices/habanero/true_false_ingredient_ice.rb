module Habanero
  module TrueFalseIngredientIce
    extend ActiveSupport::Concern

    def column_type
      :boolean
    end
  end
end
