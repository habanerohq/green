require 'spec_helper'

describe Habanero::Query do
  it { should belong_to(:sorbet) }
  it { should have_many(:conditions) }

  it { should validate_presence_of(:sorbet) }

  before(:each) do
    @sorbet = Habanero::Sorbet.find_by_name('Sorbet')
    @query = Habanero::Query.new :sorbet => @sorbet
  end

  it 'should return all records of given sorbet type without any conditions' do
    @query.evaluate.should == Habanero::Sorbet.all
  end

  it 'should return only records matching conditions' do
    condition = @query.conditions.build(
      :ingredient => @sorbet.ingredients.find_by_name('Name'),
      :predicate => 'eq',
      :value => 'Sorbet'
    )

    @query.evaluate.should == [@sorbet]
  end

  it 'should support chaniging value of conditions via params' do
    condition = @query.conditions.build(
      :ingredient => @sorbet.ingredients.find_by_name('Name'),
      :predicate => 'eq',
      :value => 'Sorbet'
    )

    @query.evaluate.should == [@sorbet]

    # save the query so that we get some ids to play with
    condition.save
    condition.should be_persisted

    params = { :q => { condition.id => 'Brand' }}
    @query.evaluate(params).should == [Habanero::Sorbet.find_by_name('Brand')]

    # make sure this works with the id as a string too
    params = { :q => { "#{condition.id}" => 'Page' }}
    @query.evaluate(params).should == [Habanero::Sorbet.find_by_name('Page')]
  end

end
