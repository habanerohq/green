require 'spec_helper'

describe Habanero::ScenesHelper do
  before do
    @scene = scene = Habanero::Scene.new(:name => 'Foo', :signpost => '/foo/(:id)')
    @scene.id = 3 # named signposts for scenes use the id
    @garden = @scene.build_garden :name => 'Bar', :signpost => '/bar'
    @site = @garden.build_site :name => 'Baz'

    Sorbet2::Application.routes.draw do
      # this has to be scene, not @scene, probably due to how the block is eval'd
      scene.label_signpost(self)
    end
  end

  it 'generates a URL using the correct signpost' do
    helper.scene_path(@scene).should == '/bar/foo'
  end

  it 'generates a URL using the passed parameters' do
    helper.scene_path(@scene, :id => 'moo').should == '/bar/foo/moo'
  end
end
