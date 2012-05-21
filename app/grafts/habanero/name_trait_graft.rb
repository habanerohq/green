module Habanero
  module NameTraitGraft
    extend ActiveSupport::Concern

    included do
      validate do |record|
        variety = record.variety

        if variety.traits.select { |i| i.class == self.class }.count > 1
          record.errors.add(:traits, "cannot have more than one #{self.class.name}")
        end
      end
    end

    def adapt(klass)
      klass.class_eval <<-RUBY_EVAL
        def self.to_s_method_names
          '#{(self.children.map(&:method_name) << self.method_name).join(', ')}'
        end
      RUBY_EVAL

      klass.send :include, Graft
    end

    module Graft        
      extend ActiveSupport::Concern
    
      module ClassMethods
        def default_order
          order(to_s_method_names)
        end      
      end

      def to_s
        _to_s
      end

      def _to_s
        self.class.to_s_method_names.split(', ').map { |m| self.send(m) }.join(' ')
      end
    end    
  end
end
