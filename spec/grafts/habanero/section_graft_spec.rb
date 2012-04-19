require 'spec_helper'

describe Habanero::Section do
  it { should belong_to(:site) }
  it { should have_many(:pages) }

  # nested set stuff
  it { should belong_to(:parent) }
  it { should have_many(:children) }

  it { should validate_presence_of(:name) }

  before(:each) do
    @section = Habanero::Section.new :name => 'Foo', :route => '/foo'
  end

  it 'should have a qualified path consisting of nested sections' do
    @section.build_parent(:name => 'Bar', :route => '/bar')
    @section.qualified_path.should == '/bar/foo'
  end
end
