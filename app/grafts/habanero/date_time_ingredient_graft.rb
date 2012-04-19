module Habanero
  module DateTimeIngredientGraft
    extend ActiveSupport::Concern

    def column_type
      :datetime
    end
  end
end
