module Habanero
  module Inputs
    class CategoryInput < Base
      def input
        @builder.collection_select(
          trait.column_name, collection, :id, :to_s,
          input_options, input_html_options
        )
      end

      def input_options
        options.reverse_merge!(:include_blank => true, :prompt => prompt_text)
      end

      private

      def collection
        trait.category.try(:children) || []
      end

      def prompt_text
        if trait.category
          "-- select one #{trait.category.name.downcase} --"
        else
          "** no options for #{trait} **"
        end
      end
    end
  end
end
