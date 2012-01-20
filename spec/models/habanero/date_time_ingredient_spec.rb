require 'spec_helper'
require 'models/habanero/ingredient_examples_helper'

module Habanero
  class DateTimeIngredient < Ingredient
    include DateTimeIngredientIce
  end
end

describe Habanero::DateTimeIngredient do
  include Habanero::IngredientExamplesHelper

  let (:ingredient) { test_ingredient(Habanero::DateTimeIngredient) }

  it_behaves_like "any ingredient"
  it_behaves_like "any simple ingredient"
end
