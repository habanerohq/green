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
      klass.class_eval <<-RUBY_EVAL
        def _to_s
          #{(self.children.map(&:method_name) << self.method_name).join(' << ')}
        end

        def self.to_s_methods
          '#{self.children.map(&:method_name) << self.method_name}'.split(' ')
        end
      RUBY_EVAL

      klass.send :include, Ice
    end

    module Ice
      def to_s
        _to_s
      end

      def to_s_qual
        to_s
      end
    end    

#    def name
#      'Name'
#    end
  end
end
