class String
  def attrify # an attribute identifier in the ruby idiom
    constify.underscore.unslash
    titleize.gsub(/\s/, '').underscore.gsub('/', '_')
  end
  
  def idify # an identitier in the script/css idiom
    underscore.gsub(/\s|_/, '-')[/[A-Za-z0-9\-]*/]
  end

  def constify
    titleize.gsub(/\s/, '')
  end

  def unslash
    gsub('/', '')
  end
end
