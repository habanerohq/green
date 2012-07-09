module Habanero
  module ThemesHelper
    def current_theme
      Habanero::Site.current.try(:theme)
    end
  end
end
