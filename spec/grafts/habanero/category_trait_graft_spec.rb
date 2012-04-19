require 'spec_helper'

describe Habanero::CategoryTrait do
  before(:all) do
    @trait = Habanero::CategoryTrait.new(:name => 'Foo Type')

    @variety = Habanero::Variety.create!(
      :name => 'Dummy',
      :parent => Habanero::Variety.find_by_name('Base'),
      :brand => Habanero::Brand.find_by_name('Habanero')
    )

    @variety.traits << Habanero::StringTrait.new(:name => 'Foo')
    @variety.traits << @trait
  end

  after(:all) do
    Habanero::Variety.find_by_name('Dummy').try(:destroy)
  end

  it 'has a column name, method name and position name' do
    @trait.method_name.should == 'foo_type' 
    @trait.column_name.should == 'foo_type_id'
  end

  it 'has a column type' do
    @trait.column_type.should == :integer
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
