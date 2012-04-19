require 'spec_helper'

describe Habanero::NameIngredient do
  before(:all) do
    @ingredient = Habanero::NameIngredient.new :name => 'Name', :format => '{{ name }}'

    @variety = Habanero::Variety.create!(
      :name => 'NameIngredientTestVariety',
      :parent => Habanero::Variety.find_by_name('Base'),
      :brand => Habanero::Brand.find_by_name('Habanero')
    )

    @variety.ingredients << @ingredient

    @variety.chill!
  end

  after(:all) do
    Habanero::Variety.find_by_name('NameIngredientTestVariety').try(:destroy)
  end

  it 'should not allow more than one NameIngredient per Variety' do
    @variety.should be_valid

    @variety.ingredients << Habanero::NameIngredient.new
    @variety.should_not be_valid
  end

  it 'should have a format' do
    @ingredient.format.should_not be_blank
  end

  it 'should define a to_s method on the variety' do
    record = Habanero::NameIngredientTestVariety.new :name => 'Foo'
    record.to_s.should == 'Foo'
  end
end
