module Habanero
  class PageCollectionCell < Habanero::SorbetCollectionCell
    def button_group(options)
      _list(options)
      render
    end

    def button_dropdown(options)
      _list(options)
      render
    end
  end
end
