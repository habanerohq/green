require 'spec_helper'

describe Habanero::NameIngredient do
  before do
    @ingredient = Habanero::NameIngredient.new

    @namespace = Habanero::Namespace.find_by_name('Habanero')
    @parent = Habanero::Sorbet.find_by_name('Base')
    @sorbet = Habanero::Sorbet.create!(
      :name => 'NameIngredientTestSorbet',
      :parent => @parent,
      :namespace => @namespace,
      :ingredients => [@ingredient]
    )
  end

  it 'should have an explicit name' do
    @ingredient.name.should == 'Name'
    @ingredient.qualified_name.should == 'name'
    @ingredient.column_name.should == 'name'
    @ingredient.method_name.should == 'name'
  end

  it 'should not allow name to be set' do
    @ingredient.name = 'Foo'
    @ingredient.name.should == 'Name'
  end

  it 'should not allow more than one NameIngredient per Sorbet' do
    @sorbet.should be_valid

    @sorbet.ingredients << Habanero::NameIngredient.new
    @sorbet.should_not be_valid
  end

  it 'should define a to_s method on the sorbet' do
    @sorbet.chill!

    record = Habanero::NameIngredientTestSorbet.new :name => 'Foo'
    record.to_s.should == 'Foo'
  end
end
