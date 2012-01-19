require 'spec_helper'
require 'models/habanero/ingredient_examples_helper'

module Habanero
  class IntegerIngredient < Ingredient
    include IntegerIngredientIce
  end
end

describe Habanero::IntegerIngredient do
  include Habanero::IngredientExamplesHelper

  let (:klass) { Habanero::IntegerIngredient }
  let (:ingredient) { test_ingredient(klass) }

  it_behaves_like "any ingredient"
  it_behaves_like "any simple ingredient"
end
