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
        path = page_path(@page, placement_param => { :sort_ingredient_id => ingredient.id, :sort_direction => (new_sort_direction if sorted?(ingredient)) })
        (link_to ingredient.to_s, path) + ((sort_direction_marker if sorted?(ingredient)) || '')
      end
    end

    def header_classes(ingredient)
      [
        (params[placement_param][:sort_direction] if sorted?(ingredient))
      ].compact.join(' ')
    end

    def sorted?(ingredient)
      params[placement_param] and params[placement_param][:sort_ingredient_id] == ingredient.id.to_s
    end

    def new_sort_direction
      swap_sort_direction(params[placement_param][:sort_direction])
    end

    def swap_sort_direction(d)
      d == 'desc' ? 'asc' : 'desc'
    end

    def sort_direction_marker
      content_tag(:span) do
        content_tag(:i, nil, :class => sort_direction_class)
      end
    end
    
    def sort_direction_class
      params[placement_param][:sort_direction] == 'desc' ? 'icon-chevron-down' : 'icon-chevron-up'
    end
  end
end