module Habanero  
  module IngredientsHelper
    def format_habanero_category_ingredient(target, ingredient)
      if v = value_for(target, ingredient)
        ingredient_span(ingredient) do
          v.name
        end
      end
    end

    def format_habanero_currency_ingredient(target, ingredient)
      if v = value_for(target, ingredient)
        ingredient_span(ingredient) do
          number_to_currency v, :precision => ingredient.precision || 2
        end
      end
    end

    def format_habanero_percentage_ingredient(target, ingredient)
      if v = target.send(ingredient.method_name)
        ingredient_span(ingredient) do
          number_to_percentage v, :precision => ingredient.precision || 1
        end
      end
    end

    def format_habanero_range_ingredient(target, ingredient)
      ingredient_span(ingredient) do
        ingredient.children.map { |c| target.send(c.method_name) }.join('...')
      end
    end

    def format_habanero_true_false_ingredient(target, ingredient)
      v = "#{target.send(ingredient.method_name)}"
      ingredient_span(ingredient, :class => v.idify) { v }
    end

    def format_habanero_nest_ingredient(target, ingredient)
      ingredient_span(ingredient) do 
        content_tag(:dl) do
          content_tag(:dt, 'parent') << content_tag(:dd, target.parent.to_s) <<
          content_tag(:dt, 'children') << content_tag(:dd, target.children.map(&:to_s).join(', '))
        end
      end
    end

    def format_habanero_association_ingredient(target, ingredient)
      if ingredient.relation == 'has_many'
        ingredient_span(ingredient) do 
#          value_for(target, ingredient).map(&:to_s).join(', ')
          content_tag(:dl) do
            value_for(target, ingredient).inject('') do |m, o|
              m << 
              content_tag(:dt, o.to_s) <<
              content_tag(:dd, (o.documentation if o.respond_to?(:documentation)))
            end.html_safe
          end
        end
      else
        value_for(target, ingredient)
      end
    end

    def format_ingredient(target, ingredient)
      method = "format_#{ingredient.class.name.attrify}"
      if respond_to?(method) && ingredient.class != Habanero::Ingredient
        send(method, target, ingredient)
      else
        ingredient_span(ingredient) { "#{value_for(target, ingredient)}" }
      end
    end

    def ingredient_span(ingredient, options = {}, &block)
      options[:class] = "#{ingredient_css_classes(ingredient)} #{options[:class]}"
      content_tag(:span, options, &block)
    end

    def ingredient_css_classes(ingredient)
      "ingredient #{ingredient.class.to_s.idify} #{ingredient.qualified_name.idify}"
    end
    
    def value_for(target, ingredient)
      target.send(ingredient.name.attrify)
    end
  end
end