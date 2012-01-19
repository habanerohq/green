require 'spec_helper'
require 'models/habanero/ingredient_examples_helper'

module Habanero
  class TrueFalseIngredient < Ingredient
    include TrueFalseIngredientIce
  end
end

describe Habanero::TrueFalseIngredient do
  include Habanero::IngredientExamplesHelper

  let (:klass) { Habanero::TrueFalseIngredient }
  let (:ingredient) { test_ingredient(klass) }

  it_behaves_like "any ingredient"
  it_behaves_like "any simple ingredient"
end
