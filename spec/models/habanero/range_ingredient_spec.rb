require 'spec_helper'
require 'models/habanero/ingredient_examples_helper'

module Habanero
  class RangeIngredient < Ingredient
    include RangeIngredientIce
  end
end

module Habanero
  class DateIngredient < Ingredient
    include DateIngredientIce
  end
end

describe Habanero::RangeIngredient do
  include Habanero::IngredientExamplesHelper

  let (:meta) { meta_ingredient('RangeIngredient') }
  let (:ingredient) { test_ingredient(Habanero::RangeIngredient) }

  it_behaves_like "any ingredient"
  
  describe 'specialises Ingredient' do
    it 'has a base sorbet' do
      meta.base.name.should == 'Ingredient'
      meta.table_name.should == 'habanero_ingredients'
    end
  end  
  
  describe 'has a composite structure' do
    let (:meta_date) {
      Habanero::Sorbet.create!(
        :name => 'DateIngredient',
        :namespace => Habanero::Namespace.find_by_name('Habanero'),
        :parent => Habanero::Sorbet.find_by_name('Ingredient')
      )
    }

    let (:start_date) { Habanero::DateIngredient.new(:name => 'Start', :sorbet => ingredient.sorbet) }
    let (:end_date) { Habanero::DateIngredient.new(:name => 'End', :sorbet => ingredient.sorbet) }
    
    before(:each) do
      ingredient.children << start_date
      ingredient.children << end_date
      ingredient.save!
    end

    it 'has minimum and maximum ingredients' do
      ingredient.sorbet.save!
      cols = ActiveRecord::Base.connection.columns(ingredient.sorbet.table_name)
      cols.map(&:name).should include 'test_ingredient_start'
      cols.detect{|c| c.name == 'test_ingredient_start'}.type.should == :date
      cols.map(&:name).should include 'test_ingredient_end'
      cols.detect{|c| c.name == 'test_ingredient_end'}.type.should == :date
    end
  end
end
