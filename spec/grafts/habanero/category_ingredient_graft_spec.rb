require 'spec_helper'

describe Habanero::CategoryIngredient do
  before(:all) do
    @ingredient = Habanero::CategoryIngredient.new(:name => 'Foo Type')

    @variety = Habanero::Variety.create!(
      :name => 'Dummy',
      :parent => Habanero::Variety.find_by_name('Base'),
      :brand => Habanero::Brand.find_by_name('Habanero')
    )

    @variety.ingredients << Habanero::StringIngredient.new(:name => 'Foo')
    @variety.ingredients << @ingredient
  end

  after(:all) do
    Habanero::Variety.find_by_name('Dummy').try(:destroy)
  end

  it 'has a column name, method name and position name' do
    @ingredient.method_name.should == 'foo_type' 
    @ingredient.column_name.should == 'foo_type_id'
  end

  it 'has a column type' do
    @ingredient.column_type.should == :integer
  end

  it 'builds belongs_to association' do 
    a = Habanero::Dummy.reflect_on_association(:foo_type)
    a.should be_present
    a.class_name.should == 'Habanero::Category'
    a.foreign_key.should == 'foo_type_id'
    a.macro.should == :belongs_to
  end

  it 'maintains columns in the variety database table' do
    ActiveRecord::Base.connection.columns('habanero_dummies').map(&:name).should include 'foo_type_id'
    Habanero::Dummy.new.should respond_to 'foo_type'
  end
end