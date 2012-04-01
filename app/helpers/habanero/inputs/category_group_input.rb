module Habanero
  module Inputs
    class CategoryGroupInput < Base
      def input
        @builder.grouped_collection_select(
          ingredient.method_name, collection,
          :children, :name, :id, :name,
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
