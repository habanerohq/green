module Habanero
  module RangeIngredientGraft
    extend ActiveSupport::Concern
    
    include DerivedIngredient

    included do
      after_create :create_range_bounds
    end

    protected

    def create_range_bounds
        ['from', 'to'].each do |i| 
          associated_type.klass.create!(:name => i, :sorbet => self.sorbet, :parent => self)
        end if associated_type
    end
  end
end
