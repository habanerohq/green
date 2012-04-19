module Habanero
  module CurrencyTraitGraft
    extend ActiveSupport::Concern

    def column_type
      :decimal
    end
  end
end
