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
end
