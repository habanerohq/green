module Habanero
  module IngredientGraft
    extend ActiveSupport::Concern
    
    def to_s_qual
      "#{name} (#{variety})"
    end
  end
end
