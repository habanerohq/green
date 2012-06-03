module Jalapeno
  module PermissionGraft
    extend ActiveSupport::Concern
    
    def to_s
      "#{role} #{action.to_s.pluralize} #{variety}"
    end
  end
end
