module Habanero
  module MaskIce
    extend ActiveSupport::Concern
    
    def ingredients
      mask_ingredients.map(&:ingredient)
    end
  end
end
