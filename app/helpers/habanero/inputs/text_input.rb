module Habanero
  module Inputs
    class TextInput < Base
      def input
        options[:class] = (options[:class].to_s || '') << ' ' << @builder.template.html_enabled_input_class unless trait.no_html?
        @builder.text_area(trait.column_name, options)
      end
    end
  end
end
