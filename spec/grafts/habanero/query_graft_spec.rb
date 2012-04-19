require 'spec_helper'

describe Habanero::Query do
  it { should belong_to(:variety) }
  it { should have_many(:conditions) }

  it { should validate_presence_of(:variety) }

  before(:each) do
    @variety = Habanero::Variety.find_by_name('Variety')
    @query = Habanero::Query.new :variety => @variety
  end

  it 'should return all records of given variety type without any conditions' do
    @query.evaluate.should == Habanero::Variety.all
  end

  it 'should return only records matching conditions' do
    condition = @query.conditions.build(
      :trait => @variety.traits.find_by_name('Name'),
      :predicate => 'eq',
      :value => 'Variety'
    )

    @query.evaluate.should == [@variety]
  end

  it 'should support chaniging value of conditions via params' do
    condition = @query.conditions.build(
      :trait => @variety.traits.find_by_name('Name'),
      :predicate => 'eq',
      :value => 'Variety'
    )

    @query.evaluate.should == [@variety]

    # save the query so that we get some ids to play with
    condition.save
    condition.should be_persisted

    params = { :q => { condition.id => 'Brand' }}
    @query.evaluate(params).should == [Habanero::Variety.find_by_name('Brand')]

    # make sure this works with the id as a string too
    params = { :q => { "#{condition.id}" => 'Page' }}
    @query.evaluate(params).should == [Habanero::Variety.find_by_name('Page')]
  end

end
