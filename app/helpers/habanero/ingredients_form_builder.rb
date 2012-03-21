module Habanero
  class IngredientsFormBuilder < ::SimpleForm::FormBuilder
    # todo: somehow dynamically loop through all availble inputs here
    map_type :'habanero/association_ingredient', :to => Habanero::Inputs::AssociationInput
    map_type :'habanero/nest_ingredient',        :to => Habanero::Inputs::NestInput
    map_type :'habanero/category_ingredient',    :to => Habanero::Inputs::CategoryInput

    def input(attribute_name, options={}, &block)
      if ingredient = options[:ingredient]
        options.reverse_merge! default_ingredient_options(ingredient)
      end

      super
    end

    def default_ingredient_options(ingredient)
      { :label => ingredient.name,
        # todo: add more default options, hints etc.
      }
    end

    protected

    def default_input_type(attribute_name, column, options) #:nodoc:
      if options[:ingredient]
        input_type = options[:ingredient].class.name.underscore.to_sym
        return input_type if self.class.mappings.has_key?(input_type)
      end

      super
    end
  end
end
