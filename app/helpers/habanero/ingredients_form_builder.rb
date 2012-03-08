module Habanero
  class IngredientsFormBuilder < ActionView::Helpers::FormBuilder

    def habanero_category_ingredient(i)
      grouped_collection_select i.method_name, i.category.children, 
        :children, :name, :id, :name, 
        :include_blank => true,
        :prompt => "--- select one #{i.category.name.downcase} ---"
    end

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
      collection = object.class._sorbet.base.klass.unscoped.order(:name)
      collection_select :parent_id, 
        collection, 
        :id, :to_s, 
        :include_blank => true,
        :prompt => "--- select one #{i.to_s.downcase} ---"
    end

    def habanero_relation_ingredient(i)
      # do nothing
    end

    def habanero_association_ingredient(i)
      if i.relation == 'belongs_to'
        collection_select i.column_name, 
          (object.class.reflect_on_association(i.name.attrify.to_sym).klass.order(:name)), 
          :id, :to_s, 
          :include_blank => true,
          :prompt => "--- select one #{i.to_s.downcase} ---"
      end
      # todo: provide the ability to add to has_many lists
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
