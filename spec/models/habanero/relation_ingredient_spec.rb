require 'spec_helper'
require 'models/habanero/ingredient_examples_helper'

module Habanero
  class RelationIngredient < Ingredient
    include RelationIngredientIce
  end
end

module Habanero
  class AssociationIngredient < Ingredient
    include AssociationIngredientIce
  end
end

describe Habanero::RelationIngredient do
  include Habanero::IngredientExamplesHelper

  let (:meta) { meta_ingredient('RelationIngredient') }
  let (:ingredient) { test_ingredient(Habanero::RelationIngredient) }
  let (:ordered) { Habanero::TrueFalseIngredient.new(:name => 'Ordered') }
  
  before(:each) do
    meta.ingredients << ordered
    meta.save!
  end

  it_behaves_like "any ingredient"
  
  describe 'specialises Ingredient' do
    it 'has a base sorbet' do
      meta.base.name.should == 'Ingredient'
      meta.table_name.should == 'habanero_ingredients'
    end

    it 'has an ordered column' do
      cols = ActiveRecord::Base.connection.columns('habanero_ingredients')
      cols.map(&:name).should include 'ordered'
      cols.detect{|c| c.name == 'ordered'}.type.should == :boolean
    end
  end  
end
