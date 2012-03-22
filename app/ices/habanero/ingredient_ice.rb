module Habanero
  module IngredientIce
    extend ActiveSupport::Concern
    
    def to_s_qual
      "#{name} (#{sorbet})"
    end
  end
end
