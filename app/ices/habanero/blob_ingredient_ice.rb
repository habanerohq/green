module Habanero
  module BlobIngredientIce
    extend ActiveSupport::Concern

    def column_type
      :binary
    end
  end
end
