module Habanero
  module LayoutRowGraft
    extend ActiveSupport::Concern
    
    def to_s_qual
      "#{name} (#{layout})"
    end
  end
end
