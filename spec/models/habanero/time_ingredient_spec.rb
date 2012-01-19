require 'spec_helper'
require 'models/habanero/ingredient_examples_helper'

module Habanero
  class TimeIngredient < Ingredient
    include TimeIngredientIce
  end
end

describe Habanero::TimeIngredient do
  include Habanero::IngredientExamplesHelper

  let (:klass) { Habanero::TimeIngredient }
  let (:ingredient) { test_ingredient(klass) }

  it_behaves_like "any ingredient"
  it_behaves_like "any simple ingredient"
end
