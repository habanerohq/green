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
  
  describe 'has a composite structure' do
    let (:other) { Habanero::Sorbet.new(
        :name => 'Other Sorbet',
        :namespace => Habanero::Namespace.new(:name => 'Other Namespace'),
        :parent => Habanero::Sorbet.new(
          :name => 'Base', 
          :namespace => Habanero::Namespace.new(:name => 'Habanero')
        )
      )
    }
    
    let (:meta_association) {
      Habanero::Sorbet.create!(
        :name => 'AssociationIngredient',
        :namespace => Habanero::Namespace.find_by_name('Habanero'),
        :parent => Habanero::Sorbet.find_by_name('Ingredient'),
        :ingredients => [
          Habanero::StringIngredient.new(:name => 'Relation')
        ]
      )
    }

=begin
# relation is not being added as a column to ingredients table !!!???
    let (:association) { Habanero::AssociationIngredient.new(:name => 'Other Sorbets', :relation => 'has_many', :sorbet => ingredient.sorbet) }
    let (:inverse) { Habanero::AssociationIngredient.new(:name => 'Test Sorbet', :relation => 'belongs_to', :sorbet => other) }
    
    before(:each) do
      other.save!
      ingredient.children << association
      ingredient.children << inverse
      ingredient.save!
    end
=end

    it 'has associates' do
    end
  end
end
