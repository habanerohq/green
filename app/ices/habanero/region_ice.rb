module Habanero
  module RegionIce
    extend ActiveSupport::Concern
    
    def to_s
      "#{name} (#{layout})"
    end
  end
end
