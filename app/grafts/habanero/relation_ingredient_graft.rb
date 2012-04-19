module Habanero
  module RelationIngredientGraft
    extend ActiveSupport::Concern

    include DerivedIngredient

    included do
      before_create :derive_name
      after_create :create_associations
    end

    protected
    
    def derive_name
      if respond_to?(:associated_name)
        an = associated_name.try(:downcase)
        self.name = "#{name} #{an}" unless an.blank? or name.include?(an)
      end
    end

    def create_associations
      if respond_to?(:associated_name) and respond_to?(:associated_type) and associated_type.present?
        Habanero::AssociationIngredient.create(:parent => self, :name => self.associated_name, :relation => 'has_many', :sorbet => self.sorbet)
        Habanero::AssociationIngredient.create(:parent => self, :name => self.name.gsub(" #{associated_name.downcase}", ''), :relation => 'belongs_to', :sorbet => self.associated_type)
      end
    end
  end
end