module Habanero
  module GardenPlacementGraft
    extend ActiveSupport::Concern

    def to_s
      "#{garden}"
    end
  end
end
