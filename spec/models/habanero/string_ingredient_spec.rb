require 'spec_helper'
require 'models/habanero/ingredient_examples_helper'

module Habanero
  class StringIngredient < Ingredient
  end
end

describe Habanero::StringIngredient do
  include Habanero::IngredientExamplesHelper

  let (:klass) { Habanero::StringIngredient }
  let (:ingredient) { test_ingredient(klass) }

  it_behaves_like "any ingredient"
  it_behaves_like "any simple ingredient"
end
