module Habanero
  class AssociationInput < SimpleForm::Inputs::Base

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

    def ingredient
      # todo: monkeypatch simple_form to make it easier to get this
      @ingredient ||= object.class._sorbet.all_ingredients.detect { |i| i.method_name.to_s == attribute_name }
    end

    def associated_model
      object.class.reflect_on_association(ingredient.name.attrify.to_sym).klass
    end

    def collection
      associated_model.unscoped.order(:name)
    end
  end
end
