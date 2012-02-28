module Habanero
  class Ingredient < ActiveRecord::Base
  end
end

Habanero::Ingredient.class_eval { include Habanero::IngredientIce }

if Habanero::Sorbet.table_exists?
  Habanero::Sorbet.namespaced('Habanero').where(:name => 'Ingredient').first.try(:adapt)
  Habanero::Ingredient.class_attribute :_sorbet
  Habanero::Ingredient._sorbet = Habanero::Sorbet.namespaced('Habanero').where(:name => 'Ingredient').first
end
