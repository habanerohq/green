require 'spec_helper'

describe Habanero::Ingredient do
  let(:sorbet) { Habanero::Sorbet.new :name => 'TestSorbet' }
  let(:namespace) { Habanero::Namespace.new :name => 'TestNamespace' }
  let(:ingredient) { Habanero::Ingredient.new :name => 'Foo Bar' }

  before(:each) do
    sorbet.namespace = namespace
    
    ingredient.sorbet = sorbet
    sorbet.ingredients << ingredient
  end

  describe "structure" do
    it "has a sorbet" do
      sorbet.ingredients.should include ingredient
    end

    it "has a name" do
      ingredient.name.should == 'Foo Bar'
    end
      
    it "has a qualified name" do
      ingredient.qualified_name.should == 'foo_bar'
    end
  end

  describe "mixing" do
    it "adds a database column to the sorbet table" do
      sorbet.save!
      ActiveRecord::Base.connection.columns(sorbet.table_name).map(&:name).should include ingredient.qualified_name
    end
    
    it "renames database column when name changed" do
      sorbet.save!
      ActiveRecord::Base.connection.columns(sorbet.table_name).map(&:name).should include 'foo_bar'

      ingredient.update_attributes :name => 'The Ingredient'
      ingredient.save!
      
      ActiveRecord::Base.connection.columns(sorbet.table_name).map(&:name).should include 'the_ingredient'
    end
    
    it "removes database column when destroyed" do
      sorbet.save!
      ActiveRecord::Base.connection.columns(sorbet.table_name).map(&:name).should include 'foo_bar'
      
      ingredient.destroy
      ActiveRecord::Base.connection.columns(sorbet.table_name).map(&:name).should_not include 'foo_bar'
    end
    
  end
end
