require 'spec_helper'

module FakeNamespace
  class FakeBase
  end
end

describe Habanero::Sorbet do
  it { should belong_to(:namespace) }
  it { should belong_to(:parent) }
  it { should have_many(:ingredients) }

  # defined by awesome_nested_set 
  it { should belong_to(:parent) }
  it { should have_many(:children) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:namespace_id) }

  before(:each) do
    @sorbet = Habanero::Sorbet.new(:name => 'Foo')
    @sorbet.parent = Habanero::Sorbet.new(:name => 'FakeBase')
    @sorbet.parent.stub(:namespace).and_return(double(:qualified_name => 'FakeNamespace', :klass => FakeNamespace))

    # define a clean fake namespace constant Baz before each test 
    Object.send :remove_const, 'Baz' if Object.constants.include?('Baz')
    @fake_module = Object.const_set 'Baz', Module.new

    @sorbet.stub(:namespace).and_return(double(:qualified_name => 'Baz', :klass => Baz))
  end

  it 'should have a qualified name' do
    @sorbet.qualified_name.should == 'Baz::Foo'
  end

  it 'should have a table name' do
    @sorbet.table_name.should == 'baz_foos'
  end

  it 'should have a class name' do
    @sorbet.klass_name.should == 'Foo'
  end

  it 'should define a constant when chilled' do
    expect { @fake_module.const_get(@sorbet.klass_name) }.to raise_error(NameError)

    klass = @sorbet.chill!
    @fake_module.const_get(@sorbet.klass_name).should == klass
  end

  it 'should return the chilled class when #klass is called' do
    expect { @fake_module.const_get(@sorbet.klass_name) }.to raise_error(NameError)

    klass = @sorbet.chill!
    @sorbet.klass.should == klass
  end

  it 'should create a table when created' do
    @sorbet.save
    @sorbet.should be_persisted

    ActiveRecord::Base.connection.tables.should include @sorbet.table_name
  end

  pending 'should not nuke already defined constants'

  it 'should unload any defined constants when dependencies are cleared' do
    expect { @fake_module.const_get(@sorbet.klass_name) }.to raise_error(NameError)

    klass = @sorbet.chill!
    @fake_module.const_get(@sorbet.klass_name).should == klass

    ActiveSupport::Dependencies.clear
    expect { @fake_module.const_get(@sorbet.klass_name) }.to raise_error(NameError)
  end

  it 'should be unloadable' do
    object_id = Habanero::Sorbet.object_id

    ActiveSupport::Dependencies.clear
    object_id.should_not == Habanero::Sorbet.object_id
  end
end
