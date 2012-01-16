require 'spec_helper'

describe Habanero::Sorbet do
  let(:sorbet) { Habanero::Sorbet.new :name => 'TestSorbet' }
  let(:namespace) { Habanero::Namespace.new :name => 'TestNamespace' }
  let(:super_sorbet) { Habanero::Sorbet.new :name => 'Base', 
                                            :namespace => Habanero::Namespace.new(:name => 'ActiveRecord')
  }

  before(:each) do
    sorbet.namespace = namespace
    sorbet.parent = super_sorbet
  end

  describe "structure" do
    let(:ingredient) { Habanero::Ingredient.new :name => 'SorbetIngredient' }
    let(:foo) { Habanero::Sorbet.new(:name => 'Foo') }
    let(:foo_ingredient) { Habanero::Ingredient.new :name => 'FooIngredient' }
    let(:bar) { Habanero::Sorbet.new(:name => 'Bar') }
    let(:bar_ingredient) { Habanero::Ingredient.new :name => 'BarIngredient' }
    
    
    before(:each) do
      foo.namespace = namespace
      bar.namespace = namespace
      
      sorbet.ingredients << ingredient
      foo.ingredients << foo_ingredient
      bar.ingredients << bar_ingredient
    end

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
    
    it "has a super sorbet" do
      sorbet.parent.should equal super_sorbet
    end
    
    it "has a base" do
      sorbet.save!
      foo.parent = sorbet
      
      # base calls self_and_ancestors which results in differing object_ids
      foo.base.id.should equal sorbet.id
    end
    
    it "includes ingredients from all supers" do
      foo.parent = sorbet
      bar.parent = foo
      [sorbet, super_sorbet, foo, bar].each(&:save!)
      
      bar.all_ingredients.should == [ingredient, foo_ingredient, bar_ingredient]
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
    
    it "redefines a class when chill! is called" do
      sorbet.chill!
      first_id = sorbet.klass.object_id
      
      sorbet.chill!
      second_id = sorbet.klass.object_id
      
      first_id.should_not == second_id
    end
    
    it "should not redefine an edge class" do
      super_sorbet.chill!
      ActiveRecord::Base.connection.should be_an ActiveRecord::ConnectionAdapters::AbstractAdapter
    end
    
    it "defines a class with configured super sorbet" do
      sorbet.chill!
      sorbet.klass.superclass.should equal ActiveRecord::Base
    end
  end

  describe "mixing" do
    it "creates a table when saved" do
      ActiveRecord::Base.connection.table_exists?(sorbet.table_name).should == false
      sorbet.save!
      ActiveRecord::Base.connection.table_exists?(sorbet.table_name).should == true
    end

    it "doesn't try to create a table when one already exists" do
      ActiveRecord::Base.connection.table_exists?(sorbet.table_name).should == false
      ActiveRecord::Base.connection.create_table sorbet.table_name
      
      expect { sorbet.save! }.to_not raise_error(ActiveRecord::StatementInvalid)
    end
  end
end
