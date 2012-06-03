module Jalapeno
  module UserGraft
    extend ActiveSupport::Concern

    def permissions
      roles.map(&:all_permissions).flatten
    end
    
    def to_s
      context.to_s
    end
  end
end
