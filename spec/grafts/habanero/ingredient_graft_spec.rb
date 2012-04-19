require 'spec_helper'

describe Habanero::Ingredient do
  it { should belong_to(:variety) }

  # nested set stuff
  it { should belong_to(:parent) }
  it { should have_many(:children) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to('variety_id') }

  before(:each) do
    @ingredient = Habanero::Ingredient.new :name => 'Foo'
  end

  it 'should have a qualified name' do
    @ingredient.qualified_name.should == 'foo'
  end

  it 'should have a column name' do
    @ingredient.column_name.should == 'foo'
  end

  it 'should have a column type' do
    @ingredient.column_type.should == :string
  end
=begin
  it 'should maintain a column in the variety database table' do
    variety = Habanero::Variety.branded('Habanero').where(:name => 'Variety').first

    ingredient = variety.ingredients.create(:name => 'Foo')
    ActiveRecord::Base.connection.columns(variety.table_name).map(&:name).should include ingredient.column_name
    Habanero::Variety.new.should respond_to ingredient.column_name

    ingredient.destroy
    ActiveRecord::Base.connection.columns(variety.table_name).map(&:name).should_not include ingredient.column_name
    Habanero::Variety.new.should_not respond_to ingredient.column_name
  end

  it 'should adapt variety as ingredients are added' do
    variety = Habanero::Variety.branded('Habanero').where(:name => 'Variety').first

    # todo: we need to actually do something to klass in #adapt to make sure
    #       that whatever changes were made to it stick
    ingredient = Habanero::Ingredient.new(:name => 'Bar')
    ingredient.should_receive(:adapt).with(variety.klass)

    variety.ingredients << ingredient
  end
=end
end
