module Habanero
  module Inputs
    class AssociationInput < Base

      def input
        case ingredient.relation.to_sym
        when :belongs_to
          @builder.collection_select(
            ingredient.column_name, collection, :id, :to_s,
            input_options, input_html_options
          )
        end
      end

      def input_options
        options.reverse_merge :include_blank => true,
                              :prompt => "-- Select #{associated_model.name} --"
      end

      private

      def associated_model
        object.class.reflect_on_association(ingredient.name.attrify.to_sym).klass
      end

      def collection
        associated_model.unscoped.order(:name)
      end
    end
  end
end
