require 'spec_helper'
require 'models/habanero/ingredient_examples_helper'

module Habanero
  class NumberIngredient < Ingredient
    include NumberIngredientIce
  end
end

describe Habanero::NumberIngredient do
  include Habanero::IngredientExamplesHelper

  let (:klass) { Habanero::NumberIngredient }
  let (:ingredient) { test_ingredient(klass) }

  it_behaves_like "any ingredient"
  it_behaves_like "any simple ingredient"
end
