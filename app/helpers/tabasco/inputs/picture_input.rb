module Tabasco
  module Inputs
    class PictureInput < Habanero::Inputs::Base

      def input
        [
          @builder.template.image_tag(target.image_url),
          '<br/>',
          @builder.file_field(trait.column_name, input_html_options),
          @builder.hidden_field("#{trait.column_name}_cache")
        ].compact.join
      end
    end
  end
end