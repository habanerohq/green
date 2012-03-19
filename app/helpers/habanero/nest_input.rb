module Habanero
  class NestInput < SimpleForm::Inputs::Base
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

    def ingredient
      # todo: monkeypatch simple_form to make it easier to get this
      @ingredient ||= object.class._sorbet.ingredients.detect { |i| i.method_name.to_s == attribute_name }
    end

    def collection
      object.class._sorbet.base.klass.unscoped.order(:name)
    end
  end
end
