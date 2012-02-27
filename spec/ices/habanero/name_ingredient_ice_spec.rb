require 'spec_helper'

describe Habanero::NameIngredient do
  before do
    @ingredient = Habanero::NameIngredient.new :name => 'Name', :format => '{{ name }}'

    @namespace = Habanero::Namespace.find_by_name('Habanero')
    @parent = Habanero::Sorbet.find_by_name('Base')
    @sorbet = Habanero::Sorbet.create!(
      :name => 'NameIngredientTestSorbet',
      :parent => @parent,
      :namespace => @namespace,
      :ingredients => [@ingredient]
    )
  end

  it 'should not allow more than one NameIngredient per Sorbet' do
    @sorbet.should be_valid

    @sorbet.ingredients << Habanero::NameIngredient.new
    @sorbet.should_not be_valid
  end

  it 'should have a format' do
    @ingredient.format.should_not be_blank
  end

  it 'should define a to_s method on the sorbet' do
    @sorbet.chill!

    record = Habanero::NameIngredientTestSorbet.new :name => 'Foo'
    record.to_s.should == 'Foo'
  end
end
