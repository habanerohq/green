module Habanero
  module HighlighterGraft
    extend ActiveSupport::Concern
    
    def traits
      highlighted_traits.map(&:trait)
    end
  end
end
