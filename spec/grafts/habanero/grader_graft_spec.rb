require 'spec_helper'

describe Habanero::Grader do
  it { should belong_to(:variety) }
  it { should have_many(:conditions) }

  it { should validate_presence_of(:variety) }

  before(:each) do
    @variety = Habanero::Variety.find_by_name('Variety')
    @grader = Habanero::Grader.new :variety => @variety
  end

  it 'should return all records of given variety type without any conditions' do
    @grader.evaluate.should == Habanero::Variety.all
  end

  it 'should return only records matching conditions' do
    condition = @grader.conditions.build(
      :trait => @variety.traits.find_by_name('Name'),
      :predicate => 'eq',
      :value => 'Variety'
    )

    @grader.evaluate.should == [@variety]
  end

  it 'should support chaniging value of conditions via params' do
    condition = @grader.conditions.build(
      :trait => @variety.traits.find_by_name('Name'),
      :predicate => 'eq',
      :value => 'Variety'
    )

    @grader.evaluate.should == [@variety]

    # save the grader so that we get some ids to play with
    condition.save
    condition.should be_persisted

    params = { :q => { condition.id => 'Brand' }}
    @grader.evaluate(params).should == [Habanero::Variety.find_by_name('Brand')]

    # make sure this works with the id as a string too
    params = { :q => { "#{condition.id}" => 'Page' }}
    @grader.evaluate(params).should == [Habanero::Variety.find_by_name('Page')]
  end

end
