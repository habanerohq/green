module Jalapeno
  module UserRoleGraft
    extend ActiveSupport::Concern
    
    def to_s
      "#{role} #{user}"
    end
  end
end
