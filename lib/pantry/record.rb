module Pantry
  module Record
    extend ActiveSupport::Concern
    include Habanero::Reflection

    module InstanceMethods
      def to_pantry
        Pantry::Item.new(self.class.name, id_values, attributes, foreign_values)
      end

      def id_values
        id_value_method_names.
        each_with_object({}) do |i, o| 
          if v = self.send(i)
            o[i] = (association_for(i) ? v.id_values : v)
          end
        end
      end
      
      def foreign_values
        self.class.reflect_on_all_associations(:belongs_to).
        each_with_object({}) do |a, o|
          ao = send a.name
          o[a.name] = ao.id_values if ao
        end
      end

      def id_value_method_names
        self.class.id_value_method_names
      end
    
      def id_value
        id_values.values.join(' ')
      end
    end

    module ClassMethods
      attr_accessor :pantry

      def id_value_method_names
        [
          # fix!
          # We commonly encounter crashes here when pantry is nil.
          # That is because pantry doesn't get set for dynamic subclasses of the class we are trying to stack.
          # Currently, we hack the pantry initialize method to trick it inot loading subclasses of the class we want to stack.
          # There are examples in the Habanero pantries that do this.
          pantry.options_for(self)[:id_value_methods] ||
            id_value_method_precedence.detect(lambda {id_value_method_names_from_uniqueness_validator}){|sym| attribute_names.include?(sym.to_s)}
        ].flatten
      end
      
      def id_value_method_precedence
        [:descriptor, :name, :label, :title]
      end
      
      def id_value_method_names_from_uniqueness_validator
        uv = validators.detect{|v| v.class == ActiveRecord::Validations::UniquenessValidator}
        [uv.options[:scope], uv.attributes].flatten.compact if uv
      end
    end
  end
end