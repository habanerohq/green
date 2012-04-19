require 'spec_helper'

module FakeBrand ; end

describe Habanero::Brand do
  it { should have_many(:varieties) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  before(:each) do
    @brand = Habanero::Brand.new(:name => 'Foo')
  end

  after(:each) do
    # make sure we clean up any constants we defined after each test
    Object.send :remove_const, 'Foo' if Object.constants.include?('Foo')
  end

  it 'should have a qualified name' do
    @brand.qualified_name.should == 'Foo'
  end

  it 'should define a constant when chilled' do
    expect { Object.const_get(@brand.qualified_name) }.to raise_error NameError

    klass = @brand.chill!
    Object.const_get(@brand.qualified_name).should == klass
  end

  it 'should return the chilled class when #klass is called' do
    expect { @brand.klass }.to raise_error NameError

    klass = @brand.chill!
    @brand.klass.should == klass
  end

  it 'should not nuke already defined constants' do
    object_id = FakeBrand.object_id
    klass = Habanero::Brand.new(:name => 'FakeBrand').chill!
    klass.object_id.should == object_id
  end

  it 'should not destroy if it has associated varieties' do
    # we assume that the variety pantry has been loaded sucessfully as part of the spec_helper
    expect { Habanero::Brand.first.destroy }.to raise_error(ActiveRecord::DeleteRestrictionError)
  end

  it 'should unload any defined constants when dependencies are cleared' do
    expect { Object.const_get(@brand.qualified_name) }.to raise_error NameError

    klass = @brand.chill!
    Object.const_get(@brand.qualified_name).should == klass

    ActiveSupport::Dependencies.clear
    expect { Object.const_get(@brand.qualified_name) }.to raise_error NameError
  end

  it 'should be unloadable' do
    object_id = Habanero::Brand.object_id

    ActiveSupport::Dependencies.clear
    object_id.should_not == Habanero::Brand.object_id
  end
end
