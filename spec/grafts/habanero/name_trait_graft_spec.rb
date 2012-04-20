require 'spec_helper'

describe Habanero::NameTrait do
  before(:all) do
    @trait = Habanero::NameTrait.new :name => 'Name', :format => '{{ name }}'

    @variety = Habanero::Variety.create!(
      :name => 'NameTraitTestVariety',
      :parent => Habanero::Variety.find_by_name('Base'),
      :brand => Habanero::Brand.find_by_name('Habanero')
    )

    @variety.traits << @trait

    @variety.germinate!
  end

  after(:all) do
    Habanero::Variety.find_by_name('NameTraitTestVariety').try(:destroy)
  end

  it 'should not allow more than one NameTrait per Variety' do
    @variety.should be_valid

    @variety.traits << Habanero::NameTrait.new
    @variety.should_not be_valid
  end

  it 'should have a format' do
    @trait.format.should_not be_blank
  end

  it 'should define a to_s method on the variety' do
    record = Habanero::NameTraitTestVariety.new :name => 'Foo'
    record.to_s.should == 'Foo'
  end
end
