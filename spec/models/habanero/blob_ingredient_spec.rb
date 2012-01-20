require 'spec_helper'
require 'models/habanero/ingredient_examples_helper'

module Habanero
  class BlobIngredient < Ingredient
    include BlobIngredientIce
  end
end

describe Habanero::BlobIngredient do
  include Habanero::IngredientExamplesHelper

  let (:ingredient) { test_ingredient(Habanero::BlobIngredient) }

  it_behaves_like "any ingredient"
  it_behaves_like "any simple ingredient"
end
