module Habanero
  module TextTraitGraft
    extend ActiveSupport::Concern
    
    def maybe_with_html_disabled(placement)
      self.no_html = true if placement.no_html?
      self
    end

    def column_type
      :text
    end
  end
end
