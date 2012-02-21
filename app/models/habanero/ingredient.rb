module Habanero
  class Ingredient < ActiveRecord::Base
  end
end

Habanero::Ingredient.class_eval { include Habanero::IngredientIce }
Habanero::Sorbet.namespaced('Habanero').where(:name => 'Ingredient').first.try(:adapt)
