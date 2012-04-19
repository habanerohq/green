module Habanero
  module SieveGraft
    extend ActiveSupport::Concern
    
    def traits
      sieve_traits.map(&:trait)
    end
  end
end
