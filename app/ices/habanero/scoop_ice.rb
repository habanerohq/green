module Habanero
  module ScoopIce
    extend ActiveSupport::Concern

    module InstanceMethods
      def cell_type
        self.class.cell_type
      end

      def template
        read_attribute(:template) || 'show'
      end
    end
    
    module ClassMethods
      def cell_type
        name.gsub('Scoop', '')
      end
    end
  end
end
