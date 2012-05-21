module Habanero
  module Inputs
    class AssociationInput < Base

      def input
        case trait.relation.to_sym
        when :belongs_to
          @builder.collection_select(
            trait.column_name, collection, :id, display_method,
            input_options, input_html_options
          )
        end
      end

      def input_options
        options.reverse_merge :include_blank => true,
                              :prompt => "-- Select #{collection_klass.try(:name)} --"
      end

      private

      def collection
        if collection_klass.respond_to?(:default_order)
          collection_klass.default_order
        else
          collection_klass.try(:unscoped) || []
        end
      end
      
      def collection_klass
        trait.polymorphic? ? @builder.object.send(trait.polymorph_name).try(:constantize) : trait.inverse_klass
      end
      
      def display_method
        collection_klass.method_defined?(:to_s_qual) ? :to_s_qual : :to_s
      end
    end
  end
end
