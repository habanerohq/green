module Habanero
  module LayoutRowIce
    extend ActiveSupport::Concern

    module InstanceMethods
      def to_s
        name
      end
    end
  end
end
