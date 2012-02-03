module Habanero
  module IngredientsFormHelper
    def ingredient_form(ingredient, target, submit_text, options = {}, &block)
      form_for(ingredient, :url => target) do |f|
        f.submit submit_text
      end
    end

    def ingredient_input(form, ingredient)
      method = ingredient.class.name.attrify << '_input'
      if respond_to?(method) && ingredient.class != Ingredient
        send(method, form, ingredient)
      else
        # todo: fix the formatting of the form, or port to a builder
        form.label(ingredient.qualified_name, ingredient.name) <<
        form.text_field(ingredient.qualified_name) <<
        '<br/>'.html_safe
      end
    end
  end
end