require 'spec_helper'
require 'models/habanero/ingredient_examples_helper'

module Habanero
  class StringIngredient < Ingredient
  end
end

describe Habanero::StringIngredient do
  include Habanero::IngredientExamplesHelper

  let (:ingredient) { test_ingredient(Habanero::StringIngredient) }

  it_behaves_like "any ingredient"
  it_behaves_like "any simple ingredient"
end
