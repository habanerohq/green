module Habanero
  module BedGraft
    extend ActiveSupport::Concern
    
    def to_s_qual
      "#{name} (#{layout})"
    end
  end
end
