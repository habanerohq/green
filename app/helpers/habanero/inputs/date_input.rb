module Habanero
  module Inputs
    class DateInput < Base
      def input
        input_html_options[:class] << :date_input
        @builder.text_field(trait.column_name, input_html_options)
      end
    end
  end
end
