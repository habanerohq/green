module Habanero
  module DateIngredientGraft
    extend ActiveSupport::Concern

    def column_type
      :date
    end
  end
end
