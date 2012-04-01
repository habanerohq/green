module Habanero
  module Inputs
    class CategoryInput < Base
      def input
        @builder.collection_select(
          ingredient.column_name, collection, :id, :to_s_qual,
          input_options, input_html_options
        )
      end

      def input_options
        options.reverse_merge!(
          :include_blank => true,
          :prompt => "-- select one #{ingredient.category.name.downcase} --"
        )
      end

      private

      def collection
        ingredient.category.children
      end
    end
  end
end
