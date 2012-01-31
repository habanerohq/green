class String
  def attrify
    titleize.gsub(/\s/, '').underscore.gsub(/\//, '_')
  end
end
