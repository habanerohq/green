module Habanero
  module MaskIngredientGraft
    extend ActiveSupport::Concern

    def to_s
      "#{ingredient}"
    end
  end
end
