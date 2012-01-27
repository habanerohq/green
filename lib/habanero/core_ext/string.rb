class String
  def attrify
    titleize.gsub('/', '').gsub(/\s/, '').underscore
  end
end