require 'spec_helper'
require 'models/habanero/ingredient_examples_helper'

module Habanero
  class DecimalIngredient < Ingredient
    include DecimalIngredientIce
  end
end

describe Habanero::DecimalIngredient do
  include Habanero::IngredientExamplesHelper

  let (:ingredient) { test_ingredient(Habanero::DecimalIngredient) }

  it_behaves_like "any ingredient"
  it_behaves_like "any simple ingredient"
end
