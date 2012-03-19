module Habanero
  class IngredientsFormBuilder < SimpleForm::FormBuilder
    def habanero_category_ingredient(i)
      grouped_collection_select i.method_name, i.category.children, 
        :children, :name, :id, :name, 
        :include_blank => true,
        :prompt => "--- select one #{i.category.name.downcase} ---"
    end

    def habanero_range_ingredient(i)
      i.children.map { |c| text_field_for(c) }.join('...')
    end

    def ingredient_input(ingredient)
      if input_class = input_for_ingredient(ingredient)
        input_type = input_class.name.underscore.to_sym
        self.class.map_type(input_type, :to => input_class)
      end

      options = default_ingredient_input_options(ingredient)

      # use custom input class via #map_type as called above
      options.reverse_merge! :as => input_type if input_type.present?
      options.reverse_merge! :disabled => true if ingredient.column_name == 'type'

      input(ingredient.method_name, options)
    end

    protected

    def input_for_ingredient(ingredient)
      begin
        return ingredient.class.name.gsub(/Ingredient$/, 'Input').constantize
      rescue NameError
      end
    end

    def default_ingredient_input_options(ingredient)
      {
        :label => ingredient.name
        # todo: add hint and other options stored with the ingredient
      }
    end
  end
end
