module Habanero
  module ScoopPlacementIce
    extend ActiveSupport::Concern

    module InstanceMethods
      def region_name
        region ? name.attrify.to_sym : :content
      end
    end
  end
end
