module Habanero
  module Inputs
    class TextInput < Base
      def input
        input_html_options[:class] << @builder.template.html_enabled_input_class unless trait.no_html?
        @builder.text_area(trait.column_name, input_html_options)
      end
    end
  end
end
