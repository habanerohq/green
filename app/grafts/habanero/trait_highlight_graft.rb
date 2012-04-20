module Habanero
  module TraitHighlightGraft
    extend ActiveSupport::Concern

    def to_s
      "#{trait}"
    end
  end
end
