module Habanero
  module IngredientGraft
    extend ActiveSupport::Concern
    
    def to_s_qual
      "#{name} (#{sorbet})"
    end
  end
end
