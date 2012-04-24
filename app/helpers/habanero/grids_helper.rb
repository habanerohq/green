module Habanero  
  module GridsHelper
    def grid_format(target, trait)
      if @placement.feature.scene

        case
        when trait.relation == 'belongs_to'
          v = target.send(trait.method_name)
          if v.present?
            link_to v, scene_path(@placement.feature.scene, target.send(trait.method_name))
          end

        when trait.type == 'Habanero::NameTrait'
          link_to_unless_current target.send(trait.method_name), scene_path(@placement.feature.scene, target)

        else
          format_trait(target, trait)
        end

      else
        format_trait(target, trait)
      end
    end

    def grid_header(trait)
      options = {
        :class => header_classes(trait)
      }
      content_tag(:th, options) do
        path = scene_path(@scene, @placement.params_key => {trait.method_name => new_sort_direction(trait)})
        (link_to trait.to_s, path) + sort_direction_marker(trait)
      end
    end

    def header_classes(trait)
      sort_direction(trait)
    end

    def sort_direction(trait)
      sort_params[trait.method_name] if sort_params
    end

    def sorted?(trait)
      sort_direction(trait).present?
    end

    def new_sort_direction(trait)
     sort_direction(trait) == 'asc' ? 'desc' : 'asc'
    end
    
    def sort_params
      params[@placement.params_key]
    end

    def sort_direction_marker(trait)
      content_tag(:span) do
        content_tag(:i, nil, :class => sort_direction_class(trait))
      end
    end
    
    def sort_direction_class(trait)
      if sorted?(trait)
        sort_direction(trait) == 'desc' ? 'icon-chevron-down' : 'icon-chevron-up'
      else
        ''
      end
    end
  end
end