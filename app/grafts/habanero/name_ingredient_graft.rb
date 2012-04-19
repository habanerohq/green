module Habanero
  module NameIngredientGraft
    extend ActiveSupport::Concern

    included do
      validate do |record|
        variety = record.variety

        if variety.ingredients.select { |i| i.class == self.class }.count > 1
          record.errors.add(:ingredients, "cannot have more than one #{self.class.name}")
        end
      end
    end

    def adapt(klass)
      klass.class_eval <<-RUBY_EVAL
        def _to_s
          #{(self.children.map(&:method_name) << self.method_name).join(' << ')}.underscore.humanize
        end

        def self.to_s_methods
          '#{self.children.map(&:method_name) << self.method_name}'.split(' ')
        end
      RUBY_EVAL

      klass.send :include, Graft
    end

    module Graft        
      extend ActiveSupport::Concern
    
      module ClassMethods
        def default_order
          order(to_s_methods)
        end      
      end

      def to_s
        _to_s
      end

      def to_s_qual
        to_s
      end
    end    
  end
end
