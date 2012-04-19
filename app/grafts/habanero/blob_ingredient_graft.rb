module Habanero
  module BlobIngredientGraft
    extend ActiveSupport::Concern

    def column_type
      :binary
    end
  end
end
