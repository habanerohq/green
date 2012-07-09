module Jalapeno
  module IdentityAssociationGraft
    extend ActiveSupport::Concern
    
    def to_s
      "#{associate} #{category} #{other}"
    end
  end
end
