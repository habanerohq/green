module Habanero  
  module IngredientsHelper
    def format_habanero_currency_ingredient(target, ingredient)
      if value = target.send(ingredient.qualified_name)
        ingredient_span(ingredient) do
          number_to_currency value, :precision => ingredient.precision || 2
        end
      end
    end

    def format_habanero_percentage_ingredient(target, ingredient)
      if value = target.send(ingredient.method_name)
        ingredient_span(ingredient) do
          number_to_percentage value, :precision => ingredient.precision || 1
        end
      end
    end

    def format_habanero_range_ingredient(target, ingredient)
      ingredient_span(ingredient) do
        ingredient.children.map { |c| target.send(c.method_name) }.join('...')
      end
    end

    def format_habanero_true_false_ingredient(target, ingredient)
      value = "#{target.send(ingredient.method_name)}"
      ingredient_span(ingredient, :class => value.idify) { value }
    end

    def format_ingredient(target, ingredient)
      method = "format_#{ingredient.class.name.underscore}"
      if respond_to?(method) && ingredient.class != Habanero::Ingredient
        send(method, target, ingredient)
      else
        ingredient_span(ingredient) { "#{target.send(ingredient.qualified_name)}" }
      end
    end

    def ingredient_span(ingredient, options = {}, &block)
      options[:class] = "#{ingredient_css_classes(ingredient)} #{options[:class]}"
      content_tag(:span, options, &block)
    end

    def ingredient_css_classes(ingredient)
      "ingredient #{ingredient.class.to_s.idify} #{ingredient.qualified_name.idify}"
    end
  end
end