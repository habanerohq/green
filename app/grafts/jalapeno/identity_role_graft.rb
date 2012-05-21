module Jalapeno
  module IdentityRoleGraft
    extend ActiveSupport::Concern
    
    def to_s_qual
      "#{to_s} (#{type.constantize._variety.to_s})"
    end
    
    def to_s
      identity.to_s
    end
  end
end
