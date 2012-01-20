require 'spec_helper'
require 'models/habanero/ingredient_examples_helper'

module Habanero
  class TrueFalseIngredient < Ingredient
    include TrueFalseIngredientIce
  end
end

describe Habanero::TrueFalseIngredient do
  include Habanero::IngredientExamplesHelper

  let (:ingredient) { test_ingredient(Habanero::TrueFalseIngredient) }

  it_behaves_like "any ingredient"
  it_behaves_like "any simple ingredient"
end
