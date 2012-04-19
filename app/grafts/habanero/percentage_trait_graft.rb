module Habanero
  module PercentageTraitGraft
    extend ActiveSupport::Concern

    def column_type
      :float
    end
  end
end
