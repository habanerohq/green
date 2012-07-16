class SitemapController < ApplicationController
  caches_action :index
  
  def index
    @urls = Habanero::Site.all.map do |s|
      @site = s

      s.gardens.map do |g|
        garden_urls(g.garden)
      end
    end.flatten.compact

    headers['Content-Type'] = 'application/xml'
    render :layout => false
  end

  protected

  def garden_urls(garden)
    garden.scenes.map do |s|
      {:loc => "http://#{@site.host}#{s.qualified_path}", :changefreq => 'weekly', :priority => 1} unless s.qualified_path.include?(':')
    end +

    garden.children.map do |sub_garden|
      garden_urls(sub_garden)
    end
  end

end
