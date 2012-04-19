module Habanero
  module RegionGraft
    extend ActiveSupport::Concern
    
    def to_s
      "#{name} (#{layout})"
    end
  end
end
