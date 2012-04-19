require 'spec_helper'

module FakeBrand
  class FakeBase
  end
end

describe Habanero::Variety do
  it { should belong_to(:brand) }
  it { should belong_to(:parent) }
  it { should have_many(:ingredients) }

  # defined by awesome_nested_set 
  it { should belong_to(:parent) }
  it { should have_many(:children) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:brand_id) }

  before(:each) do
    @variety = Habanero::Variety.new(:name => 'Foo')
    @variety.parent = Habanero::Variety.new(:name => 'FakeBase')
    @variety.parent.stub(:brand).and_return(double(:qualified_name => 'FakeBrand', :klass => FakeBrand))

    # define a clean fake brand constant Baz before each test 
    Object.send :remove_const, 'Baz' if Object.constants.include?('Baz')
    @fake_module = Object.const_set 'Baz', Module.new

    @variety.stub(:brand).and_return(double(:qualified_name => 'Baz', :klass => Baz))
  end

  it 'should have a qualified name' do
    @variety.qualified_name.should == 'Baz::Foo'
  end

  it 'should have a table name' do
    @variety.table_name.should == 'baz_foos'
  end

  it 'should have a class name' do
    @variety.klass_name.should == 'Foo'
  end

  it 'should define a constant when chilled' do
    expect { @fake_module.const_get(@variety.klass_name) }.to raise_error(NameError)

    klass = @variety.chill!
    @fake_module.const_get(@variety.klass_name).should == klass
  end

  it 'should return the chilled class when #klass is called' do
    expect { @fake_module.const_get(@variety.klass_name) }.to raise_error(NameError)

    klass = @variety.chill!
    @variety.klass.should == klass
  end

  it 'should create a table when created' do
    @variety.save
    @variety.should be_persisted

    ActiveRecord::Base.connection.tables.should include @variety.table_name
  end

  pending 'should not nuke already defined constants'

  it 'should unload any defined constants when dependencies are cleared' do
    expect { @fake_module.const_get(@variety.klass_name) }.to raise_error(NameError)

    klass = @variety.chill!
    @fake_module.const_get(@variety.klass_name).should == klass

    ActiveSupport::Dependencies.clear
    expect { @fake_module.const_get(@variety.klass_name) }.to raise_error(NameError)
  end

  it 'should be unloadable' do
    object_id = Habanero::Variety.object_id

    ActiveSupport::Dependencies.clear
    object_id.should_not == Habanero::Variety.object_id
  end

  it 'should remove constant when destroyed' do
    variety = Habanero::Variety.create!(
      :name => 'TestRemove',
      :parent => Habanero::Variety.find_by_name('Base'),
      :brand => Habanero::Brand.find_by_name('Habanero')
    )

    variety.chill!
    variety.should be_chilled
    variety.destroy
    variety.should_not be_chilled
  end
end
