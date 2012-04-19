module Habanero
  module DateTimeTraitGraft
    extend ActiveSupport::Concern

    def column_type
      :datetime
    end
  end
end
