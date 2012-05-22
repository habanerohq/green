module Habanero
  module Inputs
    class Base < SimpleForm::Inputs::Base
      protected

      def trait
        options[:trait]
      end
      
      def target
        @builder.object
      end
    end
  end
end
