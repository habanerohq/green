module Habanero
  module MaskGraft
    extend ActiveSupport::Concern
    
    def ingredients
      mask_ingredients.map(&:ingredient)
    end
  end
end
