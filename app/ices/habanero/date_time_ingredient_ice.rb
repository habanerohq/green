module Habanero
  module DateTimeIngredientIce
    extend ActiveSupport::Concern

    def column_type
      :datetime
    end
  end
end
