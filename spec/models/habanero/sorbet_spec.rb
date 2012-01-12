require 'spec_helper'

describe Habanero::Sorbet do
  let(:sorbet) { Habanero::Sorbet.new :name => 'TestSorbet' }
  let(:namespace) { Habanero::Namespace.new :name => 'TestNamespace' }
  
  before(:each) do
    sorbet.namespace = namespace
  end

  describe "structure" do
    let(:ingredient) { Habanero::Ingredient.new }

    it "has many ingredients" do
      sorbet.ingredients << ingredient
      sorbet.ingredients.last.should equal ingredient
    end

    it "has a namespace" do
      sorbet.namespace.should equal namespace
    end

    it "has a unique name" do
      sorbet.save!
      Habanero::Sorbet.new(:name => 'TestSorbet').should_not be_valid
    end

    it "has a qualified name" do
      sorbet.qualified_name.should == 'TestNamespace::TestSorbet'
    end

    it "has a table name" do
      sorbet.table_name.should == 'test_namespace_test_sorbets'
    end
  end

  describe "chilling" do
    it "defines a class with qualified name" do
      sorbet.klass
      defined?(TestNamespace::TestSorbet).should_not be nil
    end

    it "defines a subclass of ActiveRecord::Base" do
      sorbet.klass.superclass.should be ActiveRecord::Base
    end
  end

  describe "mixing" do
    it "creates a table when saved" do
      ActiveRecord::Base.connection.table_exists?(sorbet.table_name).should == false
      sorbet.save!
      ActiveRecord::Base.connection.table_exists?(sorbet.table_name).should == true
    end
    
    pending "doesn't try to create a table when one already exists"
  end
end
