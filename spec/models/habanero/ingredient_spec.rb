require 'spec_helper'
require 'models/habanero/ingredient_examples_helper'

describe Habanero::Ingredient do
  include Habanero::IngredientExamplesHelper
    
  let (:klass) { Habanero::Ingredient }
  let (:ingredient) { test_ingredient(klass) }

  it_behaves_like "any ingredient"
  it_behaves_like "any simple ingredient"
end
