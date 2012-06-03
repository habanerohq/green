module Jalapeno
  module RoleGraft
    extend ActiveSupport::Concern

    def all_permissions
      self_and_ancestors.includes(:permissions).map(&:permissions).flatten
    end
  end
end
