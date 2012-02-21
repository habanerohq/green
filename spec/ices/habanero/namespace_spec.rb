require 'spec_helper'

module FakeNamespace ; end

describe Habanero::Namespace do
  it { should have_many(:sorbets) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  before(:each) do
    @namespace = Habanero::Namespace.new(:name => 'Foo')
  end

  after(:each) do
    # make sure we clean up any constants we defined after each test
    Object.send :remove_const, 'Foo' if Object.constants.include?('Foo')
  end

  it 'should have a qualified name' do
    @namespace.qualified_name.should == 'Foo'
  end

  it 'should define a constant when chilled' do
    expect { Object.const_get(@namespace.qualified_name) }.to raise_error NameError

    klass = @namespace.chill!
    Object.const_get(@namespace.qualified_name).should == klass
  end

  it 'should return the chilled class when #klass is called' do
    expect { @namespace.klass }.to raise_error NameError

    klass = @namespace.chill!
    @namespace.klass.should == klass
  end

  it 'should not nuke already defined constants' do
    object_id = FakeNamespace.object_id
    klass = Habanero::Namespace.new(:name => 'FakeNamespace').chill!
    klass.object_id.should == object_id
  end

  it 'should not destroy if it has associated sorbets' do
    # we assume that the sorbet pantry has been loaded sucessfully as part of the spec_helper
    expect { Habanero::Namespace.first.destroy }.to raise_error(ActiveRecord::DeleteRestrictionError)
  end

  it 'should unload any defined constants when dependencies are cleared' do
    expect { Object.const_get(@namespace.qualified_name) }.to raise_error NameError

    klass = @namespace.chill!
    Object.const_get(@namespace.qualified_name).should == klass

    ActiveSupport::Dependencies.clear
    expect { Object.const_get(@namespace.qualified_name) }.to raise_error NameError
  end

  it 'should be unloadable' do
    object_id = Habanero::Namespace.object_id

    ActiveSupport::Dependencies.clear
    object_id.should_not == Habanero::Namespace.object_id
  end
end
