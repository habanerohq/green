module Habanero
  module BlobTraitGraft
    extend ActiveSupport::Concern

    def column_type
      :binary
    end
  end
end
