module Habanero  
  class IngredientsFormBuilder < ActionView::Helpers::FormBuilder

    def ingredient(i)
      method = i.class.name.attrify
      
      if respond_to?(method) && i.class != Habanero::Ingredient
        send(method, i)
      else
        @template.content_tag(:p) do
          @template.content_tag(:label, i.name) <<
          text_field(i.name.attrify)
        end
      end
    end
    
    def habanero_nest_ingredient(i)
    end
  end
end
