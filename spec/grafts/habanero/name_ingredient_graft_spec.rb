require 'spec_helper'

describe Habanero::NameIngredient do
  before(:all) do
    @ingredient = Habanero::NameIngredient.new :name => 'Name', :format => '{{ name }}'

    @sorbet = Habanero::Sorbet.create!(
      :name => 'NameIngredientTestSorbet',
      :parent => Habanero::Sorbet.find_by_name('Base'),
      :brand => Habanero::Brand.find_by_name('Habanero')
    )

    @sorbet.ingredients << @ingredient

    @sorbet.chill!
  end

  after(:all) do
    Habanero::Sorbet.find_by_name('NameIngredientTestSorbet').try(:destroy)
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
    record = Habanero::NameIngredientTestSorbet.new :name => 'Foo'
    record.to_s.should == 'Foo'
  end
end
