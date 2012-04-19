require 'spec_helper'

describe Habanero::Scene do
  it { should belong_to(:garden) }
  it { should belong_to(:layout) }
  it { should belong_to(:target) } # needs rethinking

  it { should validate_presence_of(:name) }
# it { should validate_uniqueness_of(:name).scoped_to('garden_id') }

  before(:each) do
    @scene = Habanero::Scene.new
  end

  it 'should duck type garden as parent' do
    garden = @scene.build_garden(:name => 'Foo')
    @scene.parent.should == garden
  end

  it 'should have a path' do
    @scene.route = '/dummy'
    @scene.route.should == '/dummy'
    @scene.path.should == '/dummy'
  end

  it 'should have a qualified path' do
    @scene.route = '/foo'
    @scene.qualified_path.should == '/foo'
  end

  it 'should qualify path using parent' do
    @scene.build_garden(:name => 'Foo', :route => '/foo')
    @scene.route = '/bar'
    @scene.qualified_path.should == '/foo/bar'
  end
end
