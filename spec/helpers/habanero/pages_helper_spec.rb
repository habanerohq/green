require 'spec_helper'

describe Habanero::PagesHelper do
  before do
    @page = page = Habanero::Page.new(:name => 'Foo', :route => '/foo/(:id)')
    @page.id = 3 # named routes for pages use the id
    @section = @page.build_section :name => 'Bar', :route => '/bar'
    @site = @section.build_site :name => 'Baz'

    Sorbet2::Application.routes.draw do
      # this has to be page, not @page, probably due to how the block is eval'd
      page.draw_route(self)
    end
  end

  it 'generates a URL using the correct route' do
    helper.page_path(@page).should == '/bar/foo'
  end

  it 'generates a URL using the passed parameters' do
    helper.page_path(@page, :id => 'moo').should == '/bar/foo/moo'
  end
end
