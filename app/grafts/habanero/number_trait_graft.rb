module Habanero
  module NumberTraitGraft
    extend ActiveSupport::Concern

    def column_type
      :float
    end
  end
end
