module Habanero
  module SectionIce
    extend ActiveSupport::Concern

    module InstanceMethods
      def nearest_target
        target || parent.try(:nearest_target)
      end
      
      def names_idified
        self_and_ancestors.map{ |a| a.name.idify }.join(' ')
      end
    end
  end
end
