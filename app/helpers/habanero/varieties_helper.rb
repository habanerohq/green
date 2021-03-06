module Habanero  
  module VarietiesHelper      
    def create_another_button(variety)
      if variety.leaf?
        link_to "Create another #{variety}", scene_path(variety.scene(:new), :variety_type => variety), :class => 'btn'
      else
        content_tag(:div, :class => 'btn-group') do
          content_tag(:button, 'Create another ...', :class => 'btn') <<
          content_tag(:button, :class => 'btn dropdown-toggle', 'data-toggle' => 'dropdown') do
            content_tag(:span, '', :class => :caret)
          end <<
          content_tag(:ul, :class => 'dropdown-menu') do
            variety.descendants.sort_by(&:to_s).map do |v|
              link_to v.to_s, scene_path(variety.scene(:new), :variety_type => v)
            end.join.html_safe
          end
        end
      end
    end

    def create_connector(variety, label, options={})
      if variety.leaf?
        options.merge!(:variety_type => variety)
        content_tag(:div, :class => 'btn-group') do
          link_to scene_path(variety.scene(:new), options), :class => :btn do
            (label << ' ' << content_tag(:span, '', :class => 'icon-plus-sign')).html_safe
          end
        end
      else
        content_tag(:div, :class => 'btn-group') do
          content_tag(:button, label, :class => 'btn') <<
          content_tag(:button, :class => 'btn dropdown-toggle', 'data-toggle' => 'dropdown') do
            content_tag(:span, '', :class => 'icon-plus-sign')
          end <<
          content_tag(:ul, :class => 'dropdown-menu') do
            variety.descendants.sort_by(&:to_s).map do |v|
              o = options.merge(:variety_type => v)
              link_to v.to_s, scene_path(variety.scene(:new), o)
            end.join.html_safe
          end
        end
      end
    end
      
    def connector_context_params(target, trait)
      { trait.inverse_column_name => target.id }.tap do |h|
        h[trait.inverse_polymorph_name] = trait.variety.qualified_name if trait.polymorphic?
      end
    end
  end
end