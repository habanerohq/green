module Habanero
  module MaskTraitGraft
    extend ActiveSupport::Concern

    def to_s
      "#{trait}"
    end
  end
end
