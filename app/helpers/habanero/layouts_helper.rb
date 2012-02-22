module Habanero
  module LayoutsHelper
    def layout_class(layout)
      layout.fluid? ? 'container-fluid' : 'container'
    end

    def row_class(row)
      row.fluid? ? 'row-fluid' : 'row'
    end

    def content_for_region(region, options = {})
      layout_region(region, options = {}) do
        content_for(region.name.attrify.to_sym)
      end
    end

    def layout_region(region, options = {}, &block)
      options[:class] = ["region #{region.name.idify} span#{region.span} offset#{region.offset}", options[:class]].join(' ')
      content_tag(:div, yield, options)
    end
  end
end