class String
  def attrify
    constify.unslash.underscore
  end
  
  def constify
    titleize.gsub(/\s/, '')
  end
  
  def unslash
    gsub('/', '')
  end
end