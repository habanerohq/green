require 'spec_helper'
require 'models/habanero/ingredient_examples_helper'

module Habanero
  class BlobIngredient < Ingredient
    include BlobIngredientIce
  end
end

describe Habanero::BlobIngredient do
  include Habanero::IngredientExamplesHelper

  let (:klass) { Habanero::BlobIngredient }
  let (:ingredient) { test_ingredient(klass) }

  it_behaves_like "any ingredient"
  it_behaves_like "any simple ingredient"
end
