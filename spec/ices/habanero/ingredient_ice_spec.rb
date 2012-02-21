require 'spec_helper'

describe Habanero::Ingredient do
  it { should belong_to(:sorbet) }

  # nested set stuff
  it { should belong_to(:parent) }
  it { should have_many(:children) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to('sorbet_id') }

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

  it 'should maintain a column in the sorbet database table' do
    sorbet = Habanero::Sorbet.namespaced('Habanero').where(:name => 'Sorbet').first

    ingredient = sorbet.ingredients.create(:name => 'Foo')
    ActiveRecord::Base.connection.columns(sorbet.table_name).map(&:name).should include ingredient.column_name
    Habanero::Sorbet.new.should respond_to ingredient.column_name

    ingredient.destroy
    ActiveRecord::Base.connection.columns(sorbet.table_name).map(&:name).should_not include ingredient.column_name
    Habanero::Sorbet.new.should_not respond_to ingredient.column_name
  end

  it 'should adapt sorbet as ingredients are added' do
    sorbet = Habanero::Sorbet.namespaced('Habanero').where(:name => 'Sorbet').first

    # todo: we need to actually do something to klass in #adapt to make sure
    #       that whatever changes were made to it stick
    ingredient = Habanero::Ingredient.new(:name => 'Bar')
    ingredient.should_receive(:adapt).with(sorbet.klass)

    sorbet.ingredients << ingredient
  end

end
