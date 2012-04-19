module Habanero
  module IntegerTraitGraft
    extend ActiveSupport::Concern

    def column_type
      :integer
    end
  end
end
