module Habanero
  module TraitGraft
    extend ActiveSupport::Concern
    
    def to_s_qual
      "#{name} (#{variety})"
    end
  end
end
