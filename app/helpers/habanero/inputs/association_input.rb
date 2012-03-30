module Habanero
  module Inputs
    class AssociationInput < Base

      def input
        case ingredient.relation.to_sym
        when :belongs_to
          @builder.collection_select(
            ingredient.column_name, collection, :id, :to_s_qual,
            input_options, input_html_options
          )
        end
      end

      def input_options
        options.reverse_merge :include_blank => true,
                              :prompt => "-- Select #{ingredient.inverse_klass.name} --"
      end

      private

      def collection
        ingredient.inverse_klass.default_order
      end
    end
  end
end
