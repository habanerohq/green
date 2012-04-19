module Habanero
  module Inputs
    class Base < SimpleForm::Inputs::Base
      protected

      def trait
        options[:trait]
      end
    end
  end
end
