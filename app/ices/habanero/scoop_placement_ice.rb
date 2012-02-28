module Habanero
  module ScoopPlacementIce
    extend ActiveSupport::Concern

    def region_name
      region ? region.name.attrify.to_sym : :content
    end

    def to_s
      "#{scoop} # #{template}"
    end
  end
end
