module Habanero
  module NameIngredientIce
    extend ActiveSupport::Concern

    included do
      validate do |record|
        sorbet = record.sorbet

        if sorbet.ingredients.select { |i| i.class == self.class }.count > 1
          record.errors.add(:ingredients, "cannot have more than one #{self.class.name}")
        end
      end
    end

    def adapt(klass)
      klass.class_eval do
        def to_s
          name
        end
      end
    end

    def name
      'Name'
    end
  end
end
