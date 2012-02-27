module Habanero
  module ScoopIce
    extend ActiveSupport::Concern

    module ClassMethods
      def cell_type
        name.gsub('Scoop', '')
      end
    end

    def cell_type
      self.class.cell_type
    end
  end
end
