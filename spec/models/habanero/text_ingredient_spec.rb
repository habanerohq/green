require 'spec_helper'
require 'models/habanero/ingredient_examples_helper'

module Habanero
  class TextIngredient < Ingredient
    include TextIngredientIce
  end
end

describe Habanero::TextIngredient do
  include Habanero::IngredientExamplesHelper

  let (:ingredient) { test_ingredient(Habanero::TextIngredient) }

  it_behaves_like "any ingredient"
  it_behaves_like "any simple ingredient"
end
