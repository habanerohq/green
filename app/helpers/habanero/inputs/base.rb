module Habanero
  module Inputs
    class Base < SimpleForm::Inputs::Base
      protected

      def ingredient
        options[:ingredient]
      end
    end
  end
end
