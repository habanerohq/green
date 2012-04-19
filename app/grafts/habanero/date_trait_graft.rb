module Habanero
  module DateTraitGraft
    extend ActiveSupport::Concern

    def column_type
      :date
    end
  end
end
