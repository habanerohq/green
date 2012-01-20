require 'spec_helper'
require 'models/habanero/ingredient_examples_helper'

module Habanero
  class CurrencyIngredient < Ingredient
    include CurrencyIngredientIce
  end
end

describe Habanero::CurrencyIngredient do
  include Habanero::IngredientExamplesHelper

  let (:ingredient) { test_ingredient(Habanero::CurrencyIngredient) }

  it_behaves_like "any ingredient"
  it_behaves_like "any simple ingredient"
end
