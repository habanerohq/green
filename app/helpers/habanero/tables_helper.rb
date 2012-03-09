module Habanero  
  module TablesHelper
    def table_format(target, ingredient)
      if @placement.scoop.page

        if ingredient.relation == 'belongs_to'
          v = target.send(ingredient.method_name)
          if v.present?
            link_to format_ingredient(target, ingredient), 
              page_path(@placement.scoop.page, :id => target.send(ingredient.method_name), :sorbet_type => ingredient.inverse.sorbet)
          end

        elsif ingredient.type == 'Habanero::NameIngredient'
          link_to_unless_current format_ingredient(target, ingredient), 
            page_path(@placement.scoop.page, :id => target, :sorbet_type => target.class._sorbet)

        else
          format_ingredient(target, ingredient)
        end

      else
        format_ingredient(target, ingredient)
      end
    end

    def table_header(ingredient)
      options = {
        :class => header_classes(ingredient)
      }
      content_tag(:th, options) do
        path = page_path(@page, placement_param => {ingredient.column_name=> new_sort_direction(ingredient)})
        (link_to ingredient.to_s, path) + sort_direction_marker(ingredient)
      end
    end

    def header_classes(ingredient)
      sort_direction(ingredient)
    end

    def sort_direction(ingredient)
      sort_params[ingredient.column_name] if sort_params
    end

    def sorted?(ingredient)
      sort_direction(ingredient).present?
    end

    def new_sort_direction(ingredient)
     sort_direction(ingredient) == 'asc' ? 'desc' : 'asc'
    end
    
    def sort_params
      params[placement_param]
    end

    def sort_direction_marker(ingredient)
      content_tag(:span) do
        content_tag(:i, nil, :class => sort_direction_class(ingredient))
      end
    end
    
    def sort_direction_class(ingredient)
      if sorted?(ingredient)
        sort_direction(ingredient) == 'desc' ? 'icon-chevron-down' : 'icon-chevron-up'
      else
        ''
      end
    end
  end
end