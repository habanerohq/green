xml = Builder::XmlMarkup.new

xml.instruct!
xml.tag! 'urlset' do
  @urls.each do |url|
    xml.tag! 'url' do
      url.each do |key, val|
        xml.tag! key, val
      end
    end
  end
end
