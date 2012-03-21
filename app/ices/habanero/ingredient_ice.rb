module Habanero
  module IngredientIce
    extend ActiveSupport::Concern
    
    def to_s
      "#{name} (#{sorbet})"
    end
  end
end
