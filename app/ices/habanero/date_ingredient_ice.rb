module Habanero
  module DateIngredientIce
    extend ActiveSupport::Concern

    def column_type
      :date
    end
  end
end
