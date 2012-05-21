module Habanero
  module Inputs
    class CategoryGroupInput < Base
      def input
        @builder.grouped_collection_select(
          trait.method_name, collection,
          :children, :name, :id, :to_s,
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
