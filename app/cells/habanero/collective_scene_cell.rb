module Habanero
  class CollectiveSceneCell < Habanero::CollectiveVarietyCell
    def thumbnail_group(options)
      _list(options)
      render
    end

    def button_group(options)
      _list(options)
      render
    end

    def button_dropdown(options)
      _list(options)
      render
    end

    def navigation(options)
      _list(options)
      render
    end
  end
end
