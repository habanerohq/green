require 'spec_helper'

describe Habanero::Page do
  it { should belong_to(:section) }
  it { should belong_to(:layout) }
  it { should belong_to(:target) } # needs rethinking

  it { should validate_presence_of(:name) }
# it { should validate_uniqueness_of(:name).scoped_to('section_id') }

  before(:each) do
    @page = Habanero::Page.new
  end

  it 'should duck type section as parent' do
    section = @page.build_section(:name => 'Foo')
    @page.parent.should == section
  end

  it 'should have a path' do
    @page.route = '/dummy'
    @page.route.should == '/dummy'
    @page.path.should == '/dummy'
  end

  it 'should have a qualified path' do
    @page.route = '/foo'
    @page.qualified_path.should == '/foo'
  end

  it 'should qualify path using parent' do
    @page.build_section(:name => 'Foo', :route => '/foo')
    @page.route = '/bar'
    @page.qualified_path.should == '/foo/bar'
  end
end
