module Habanero
  class TraitsFormBuilder < ::SimpleForm::FormBuilder
    # todo: somehow dynamically loop through all availble inputs here
    map_type :'habanero/text_trait',        :to => Habanero::Inputs::TextInput
    map_type :'habanero/association_trait', :to => Habanero::Inputs::AssociationInput
    map_type :'habanero/category_trait',    :to => Habanero::Inputs::CategoryInput
    map_type :'habanero/date_trait',        :to => Habanero::Inputs::DateInput
    map_type :'habanero/nest_trait',        :to => Habanero::Inputs::NestInput
    map_type :'habanero/range_trait',       :to => Habanero::Inputs::RangeInput

    def input(attribute_name, options={}, &block)
      if trait = options[:trait]
        options.reverse_merge! default_trait_options(trait)
        
        if trait.polymorphic?
          v = object.send(trait.method_name)
          options[:label] = v._variety.name if v.present?
        end
      end

      super
    end

    def default_trait_options(trait)
      { :label => trait.name,
        # todo: add more default options, hints etc.
      }
    end

    protected

    def default_input_type(attribute_name, column, options) #:nodoc:
      if options[:trait]
        input_type = options[:trait].class.name.underscore.to_sym
        return input_type if self.class.mappings.has_key?(input_type)
      end

      super
    end
  end
end
