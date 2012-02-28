module Habanero
  module MaskIngredientIce
    extend ActiveSupport::Concern

    def to_s
      "#{ingredient}"
    end
  end
end
