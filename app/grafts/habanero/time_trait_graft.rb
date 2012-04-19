module Habanero
  module TimeTraitGraft
    extend ActiveSupport::Concern

    def column_type
      :time
    end
  end
end
