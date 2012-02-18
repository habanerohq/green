module Habanero
  module LayoutsHelper
    def layout_class(layout)
      layout.fluid? ? 'container-fluid' : 'container'
    end

    def row_class(row)
      row.fluid? ? 'row-fluid' : 'row'
    end

    def arrange_region(region, options = {})
      options[:class] = ["region #{region.name.idify} span#{region.span} offset#{region.offset}", options[:class]].join(' ')
      content_tag(:div, content_for(region.name.attrify.to_sym), options)
    end
  end
end