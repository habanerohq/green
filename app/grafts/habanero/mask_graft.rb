module Habanero
  module MaskGraft
    extend ActiveSupport::Concern
    
    def traits
      mask_traits.map(&:trait)
    end
  end
end
