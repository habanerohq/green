module Habanero
  module IngredientExamplesHelper
    
    shared_examples_for "any ingredient" do
      it "has a sorbet" do
        ingredient.sorbet.name.should == 'Test Sorbet'
      end

      it "has a name" do
        ingredient.name.should == 'Test Ingredient'
      end

      it "has a qualified name" do
        ingredient.qualified_name.should == 'test_ingredient'
      end
    end

    shared_examples_for "any simple ingredient" do
      it "adds a database column with the correct type to the sorbet table" do
        ingredient.sorbet.save!
        cols = ActiveRecord::Base.connection.columns(ingredient.sorbet.table_name)
        cols.map(&:name).should include ingredient.qualified_name
        cols.detect{|c| c.name == ingredient.qualified_name}.type.should == ingredient.column_type
      end

      it "renames database column when name changed" do
        ingredient.sorbet.save!
        ActiveRecord::Base.connection.columns(ingredient.sorbet.table_name).map(&:name).should include 'test_ingredient'

        ingredient.update_attributes :name => 'The Ingredient'
        ingredient.save!

        ActiveRecord::Base.connection.columns(ingredient.sorbet.table_name).map(&:name).should include 'the_ingredient'
      end

      it "removes database column when destroyed" do
        ingredient.sorbet.save!
        ActiveRecord::Base.connection.columns(ingredient.sorbet.table_name).map(&:name).should include 'test_ingredient'

        ingredient.destroy
        ActiveRecord::Base.connection.columns(ingredient.sorbet.table_name).map(&:name).should_not include 'test_ingredient'
      end
    end
    
    def test_ingredient(klass)
      s = Habanero::Sorbet.new(
        :name => 'Test Sorbet',
        :namespace => Habanero::Namespace.new(:name => 'Test Namespace'),
        :parent => Habanero::Sorbet.new(
          :name => 'Base', 
          :namespace => Habanero::Namespace.new(:name => 'ActiveRecord')
        )
      )
      i = klass.new(
        :name => "Test Ingredient",
        :sorbet => s
      )
      s.ingredients << i
      i
    end
  end
end