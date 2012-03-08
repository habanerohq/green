module Habanero
  class PageCollectionCell < Habanero::SorbetCollectionCell
    def button_group(options)
      list(options)
    end

    def button_dropdown(options)
      list(options)
    end

  end
end
