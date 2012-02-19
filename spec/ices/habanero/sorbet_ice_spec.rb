require 'spec_helper'

module FakeNamespace
  class FakeBase
  end
end

describe Habanero::Sorbet do
  it { should belong_to(:namespace) }
  it { should belong_to(:parent) } # defined by awesome_nested_set 
  it { should have_many(:ingredients) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:namespace_id) }

  before(:each) do
    @sorbet = Habanero::Sorbet.new(:name => 'Foo')
    @sorbet.parent = Habanero::Sorbet.new(:name => 'FakeBase')
    @sorbet.parent.stub(:namespace).and_return(double(:qualified_name => 'FakeNamespace', :klass => FakeNamespace))

    @fake_module = Module.new
    @sorbet.stub(:namespace).and_return(double(:qualified_name => 'Baz', :klass => @fake_module))
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
  pending 'should unload any defined constants when dependencies are cleared'
end
