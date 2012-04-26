module Habanero
  module RelationTraitGraft
    extend ActiveSupport::Concern

    include DerivedTrait

    included do
      after_create :create_associations
    end

    protected

    def create_associations
      if respond_to?(:associated_name) and respond_to?(:associated_type) and associated_type.present?
        Habanero::AssociationTrait.create(:parent => self, :name => self.associated_name, :relation => 'has_many', :variety => self.variety)
        Habanero::AssociationTrait.create(:parent => self, :name => self.name, :relation => 'belongs_to', :variety => self.associated_type)
      end
    end
  end
end