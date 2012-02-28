module Habanero
  module TimeIngredientIce
    extend ActiveSupport::Concern

    def column_type
      :time
    end
  end
end
