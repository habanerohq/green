require 'spec_helper'

describe Habanero::CategoryIngredient do
  before(:each) do
    @ingredient = Habanero::CategoryIngredient.new(:name => 'Foo Type')
    
    @sorbet = Habanero::Sorbet.create!(
      :name => 'Dummy',
      :parent => Habanero::Sorbet.first, # ActiveRecord::Base
      :namespace => Habanero::Namespace.find_by_name('Habanero'),
      :ingredients => [
        Habanero::StringIngredient.new(:name => 'Foo'),
        @ingredient
      ]
    )
  end

  after(:each) do
    @sorbet.destroy
    ActiveSupport::Dependencies.clear
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

  it 'maintains columns in the sorbet database table' do
    ActiveRecord::Base.connection.columns('habanero_dummies').map(&:name).should include 'foo_type_id'
    Habanero::Dummy.new.should respond_to 'foo_type'
  end
end
