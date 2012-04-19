module Habanero
  module DecimalTraitGraft
    extend ActiveSupport::Concern

    def column_type
      :decimal
    end
  end
end
