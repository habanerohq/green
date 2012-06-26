module Habanero
  module NavigationHelper
    def brand_link_value
      if brand = Tabasco::Picture.find_by_name('brand')
        image_tag(brand.image_url, :alt => brand.name, :title => brand.caption)
      else
        Habanero::Site.current.name
      end
    end
  end
end
