module Habanero
  module Inputs
    class NestInput < Base
      def input
        @builder.collection_select(
          :parent_id, collection, :id, :to_s,
          input_options, input_html_options
        )
      end

      def input_options
        options.reverse_merge :include_blank => true,
                              :prompt => '-- Select parent --'
      end

      private

      def collection
        ingredient.sorbet.base.klass.unscoped.order(:name)
      end
    end
  end
end
