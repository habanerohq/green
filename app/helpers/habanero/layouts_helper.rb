module Habanero
  module LayoutsHelper
    def layout_class(layout)
      layout.fluid? ? 'container-fluid' : 'container'
    end

    def row_class(row)
      row.fluid? ? 'row-fluid' : 'row'
    end

    def content_for_bed(bed, options = {})
      layout_bed(bed, options = {}) do
        content_for(bed.name.attrify.to_sym)
      end
    end

    def layout_bed(bed, options = {}, &block)
      options[:class] = ["bed #{bed.name.idify} span#{bed.span} offset#{bed.offset}", options[:class]].join(' ')
      content_tag(:div, yield, options)
    end
  end
end