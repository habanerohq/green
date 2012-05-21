module Habanero
  module RangeTraitGraft
    extend ActiveSupport::Concern
    
    include DerivedTrait

    included do
      after_create :create_range_bounds
    end

    protected

    def create_range_bounds
      if associated_type
        ['from', 'to'].each do |i| 
          associated_type.klass.create!(:name => i, :variety => self.variety, :parent => self)
        end
      end
    end
  end
end
