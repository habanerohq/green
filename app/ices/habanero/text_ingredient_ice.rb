module Habanero
  module TextIngredientIce
    extend ActiveSupport::Concern

    def column_type
      :text
    end
  end
end
