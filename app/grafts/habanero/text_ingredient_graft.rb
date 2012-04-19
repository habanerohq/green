module Habanero
  module TextIngredientGraft
    extend ActiveSupport::Concern

    def column_type
      :text
    end
  end
end
