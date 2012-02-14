module Habanero
  module ScoopIce
    extend ActiveSupport::Concern

    module InstanceMethods
      def cell_type
        self.class.cell_type
      end
    end

    def to_s
      name
    end
    
    module ClassMethods
      def cell_type
        name.gsub('Scoop', '')
      end
    end
  end
end
