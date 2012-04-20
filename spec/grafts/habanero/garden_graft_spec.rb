require 'spec_helper'

describe Habanero::Garden do
  it { should belong_to(:site) }
  it { should have_many(:scenes) }

  # nested set stuff
  it { should belong_to(:parent) }
  it { should have_many(:children) }

  it { should validate_presence_of(:name) }

  before(:each) do
    @garden = Habanero::Garden.new :name => 'Foo', :signpost => '/foo'
  end

  it 'should have a qualified path consisting of nested gardens' do
    @garden.build_parent(:name => 'Bar', :signpost => '/bar')
    @garden.qualified_path.should == '/bar/foo'
  end
end
