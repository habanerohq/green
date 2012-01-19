require 'spec_helper'
require 'models/habanero/ingredient_examples_helper'

module Habanero
  class DateIngredient < Ingredient
    include DateIngredientIce
  end
end

describe Habanero::DateIngredient do
  include Habanero::IngredientExamplesHelper

  let (:klass) { Habanero::DateIngredient }
  let (:ingredient) { test_ingredient(klass) }

  it_behaves_like "any ingredient"
  it_behaves_like "any simple ingredient"
end
