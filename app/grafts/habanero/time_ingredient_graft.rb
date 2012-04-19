module Habanero
  module TimeIngredientGraft
    extend ActiveSupport::Concern

    def column_type
      :time
    end
  end
end
