module Habanero
  module SectionIce
    extend ActiveSupport::Concern

    module InstanceMethods
      def nearest_sorbet
        sorbet || parent.try(:nearest_sorbet)
      end
      
      def names_idified
        self_and_ancestors.map{ |a| a.name.idify }.join(' ')
      end
    end
  end
end
