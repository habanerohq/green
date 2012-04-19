require 'spec_helper'

describe Habanero::Trait do
  it { should belong_to(:variety) }

  # nested set stuff
  it { should belong_to(:parent) }
  it { should have_many(:children) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to('variety_id') }

  before(:each) do
    @trait = Habanero::Trait.new :name => 'Foo'
  end

  it 'should have a qualified name' do
    @trait.qualified_name.should == 'foo'
  end

  it 'should have a column name' do
    @trait.column_name.should == 'foo'
  end

  it 'should have a column type' do
    @trait.column_type.should == :string
  end
=begin
  it 'should maintain a column in the variety database table' do
    variety = Habanero::Variety.branded('Habanero').where(:name => 'Variety').first

    trait = variety.traits.create(:name => 'Foo')
    ActiveRecord::Base.connection.columns(variety.table_name).map(&:name).should include trait.column_name
    Habanero::Variety.new.should respond_to trait.column_name

    trait.destroy
    ActiveRecord::Base.connection.columns(variety.table_name).map(&:name).should_not include trait.column_name
    Habanero::Variety.new.should_not respond_to trait.column_name
  end

  it 'should adapt variety as traits are added' do
    variety = Habanero::Variety.branded('Habanero').where(:name => 'Variety').first

    # todo: we need to actually do something to klass in #adapt to make sure
    #       that whatever changes were made to it stick
    trait = Habanero::Trait.new(:name => 'Bar')
    trait.should_receive(:adapt).with(variety.klass)

    variety.traits << trait
  end
=end
end
