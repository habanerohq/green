module Habanero
  class PageCollectionCell < Habanero::VarietyCollectionCell
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
