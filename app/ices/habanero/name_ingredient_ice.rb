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
      klass.send :include, Ice
    end

    module Ice
      def to_s
        name
      end

      def to_s_qual
        to_s
      end
    end    

    def name
      'Name'
    end
  end
end
