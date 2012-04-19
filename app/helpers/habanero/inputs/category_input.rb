module Habanero
  module Inputs
    class CategoryInput < Base
      def input
        @builder.collection_select(
          trait.column_name, collection, :id, :to_s_qual,
          input_options, input_html_options
        )
      end

      def input_options
        options.reverse_merge!(
          :include_blank => true,
          :prompt => "-- select one #{trait.category.name.downcase} --"
        )
      end

      private

      def collection
        trait.category.children
      end
    end
  end
end
