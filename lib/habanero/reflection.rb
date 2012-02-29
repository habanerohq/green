module Habanero
  module Reflection
    extend ActiveSupport::Concern

    module ClassMethods
      def association_for(s)
        reflect_on_association(s.to_sym)
      end
    end

    def association_for(s)
      self.class.association_for(s)
    end
  end
end
