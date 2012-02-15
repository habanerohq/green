module Habanero  
  class IngredientsFormBuilder < ActionView::Helpers::FormBuilder

    def habanero_range_ingredient(i)
      i.children.map { |c| text_field_for(c) }.join('...')
    end

    def habanero_text_ingredient(i)
      text_area_for(i)
    end

    def habanero_true_false_ingredient(i)
      check_box_for(i)
    end
    
    def habanero_nest_ingredient(i)
      select :parent, object.class.order(:name)
    end

    def habanero_association_ingredient(i)
      if i.relation == 'belongs_to'
        select i.name.attrify, (object.class.reflect_on_association(i.name.attrify.to_sym).klass.order(:name))
      end
    end
    
    def ingredient(i)
      method = i.class.name.attrify
      
      @template.content_tag(:p) do
        @template.content_tag(:label, i.name) <<
        if respond_to?(method) && i.class != Habanero::Ingredient
          send(method, i)
        else
          text_field_for(i)
        end
      end
    end
    
    def text_field_for(i)
      text_field(i.name.attrify)
    end
    
    def text_area_for(i)
      text_area(i.name.attrify)
    end
    
    def check_box_for(i)
      check_box(i.name.attrify)
    end
    
  end
end
