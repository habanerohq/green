module Habanero
  module BedGraft
    extend ActiveSupport::Concern
    
    def to_s
      "#{name} (#{layout})"
    end
  end
end
