module Habanero
  module SieveTraitGraft
    extend ActiveSupport::Concern

    def to_s
      "#{trait}"
    end
  end
end
