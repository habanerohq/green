class String
  def attrify
    titleize.gsub(/\s/, '').underscore
  end
end