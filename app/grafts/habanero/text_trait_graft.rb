module Habanero
  module TextTraitGraft
    extend ActiveSupport::Concern

    def column_type
      :text
    end
  end
end
