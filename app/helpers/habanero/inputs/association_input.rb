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
        if collection_klass
          result = collection_klass.default_order if collection_klass.respond_to?(:default_order)
          sg = scope_guess
          result = result.where(sg) if sg
          result
        else
          []
        end
      end
      
      def collection_klass
        trait.polymorphic? ? target.send(trait.polymorph_name).try(:constantize) : trait.inverse_klass
      end
      
      def scope_guess
        s = trait.inverse_variety.traits.find_by_type('Habanero::SlugTrait')
        if s.try(:scope).present?
          {s.scope.column_name => scope_value_guess(s.scope.column_name)}
        end
      end
      
      def scope_value_guess(scope_column_name)
        if target.class.respond_to?(scope_column_name) and (result = target.send(scope_column_name).present?)
          result
        else
          target.class.reflect_on_all_associations(:belongs_to).
          map do |a| 
            target.send(a.name)
          end.
          compact.
          map do |a|
            a.send(scope_column_name) if a.respond_to?(scope_column_name)
          end.
          compact
        end
      end
      
      def display_method
        collection_klass.method_defined?(:to_s_qual) ? :to_s_qual : :to_s
      end
    end
  end
end
