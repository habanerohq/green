module Habanero
  module TrueFalseTraitGraft
    extend ActiveSupport::Concern

    def column_type
      :boolean
    end
  end
end
