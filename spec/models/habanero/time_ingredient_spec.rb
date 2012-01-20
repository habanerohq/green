require 'spec_helper'
require 'models/habanero/ingredient_examples_helper'

module Habanero
  class TimeIngredient < Ingredient
    include TimeIngredientIce
  end
end

describe Habanero::TimeIngredient do
  include Habanero::IngredientExamplesHelper

  let (:ingredient) { test_ingredient(Habanero::TimeIngredient) }

  it_behaves_like "any ingredient"
  it_behaves_like "any simple ingredient"
end
