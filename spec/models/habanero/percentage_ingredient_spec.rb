require 'spec_helper'
require 'models/habanero/ingredient_examples_helper'

module Habanero
  class PercentageIngredient < Ingredient
    include PercentageIngredientIce
  end
end

describe Habanero::PercentageIngredient do
  include Habanero::IngredientExamplesHelper

  let (:ingredient) { test_ingredient(Habanero::PercentageIngredient) }

  it_behaves_like "any ingredient"
  it_behaves_like "any simple ingredient"
end
