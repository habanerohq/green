require 'spec_helper'

describe Habanero::Sorbet do
  let(:sorbet) { Habanero::Sorbet.new :name => 'TestSorbet' }
  let(:ingredient) { Habanero::Ingredient.new }
  let(:namespace) { Habanero::Namespace.new :name => 'TestNamespace' }

  describe "structure" do
    it "has many ingredients" do
      sorbet.ingredients << ingredient
      sorbet.ingredients.last.should equal ingredient
    end

    it "has a namespace" do
      sorbet.namespace = namespace
      sorbet.namespace.should equal namespace
    end

    it "has a unique name" do
      sorbet.save
      Habanero::Sorbet.new(:name => 'TestSorbet').should_not be_valid
    end

    it "has a qualified name" do
      sorbet.namespace = namespace
      sorbet.qualified_name.should == 'TestNamespace::TestSorbet'
    end
  end

  describe "chilling" do
    it "defines a class with qualified name" do
      sorbet.namespace = namespace
      sorbet.klass
      defined?(TestNamespace::TestSorbet).should_not be nil
    end
    
    it "defines a subclass of ActiveRecord::Base" do
      sorbet.namespace = namespace
      sorbet.klass.superclass.should be ActiveRecord::Base
    end
  end
end
