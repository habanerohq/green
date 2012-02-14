module Habanero
  module CellsHelper
    include PlacementsHelper
    include IngredientsHelper
    
    def cell_div(options={}, &block)
      options.reverse_merge!(:id => @placement.scoop.name.idify, :class => "cell #{cell_id.idify} #{@placement.template}")
      content_tag(:div, options, &block)
    end

    def cell_id
      controller.class.name.gsub(/cell$/i, '').attrify
    end

    def cell_title(title, &block)
      content_tag(:div, :class => 'title') do
        h(1){title.to_s} << (block.present? ? with_output_buffer(&block) :'')
      end
    end
    
    def h(offset, &block)
      level = "h#{@placement.scoop.level + offset}"
      content_tag(level, &block)
    end

    def cell_top(&block)
      content_tag(:div, :class => 'top', &block)
    end

    def cell_content(&block)
      content_tag(:div, :class => 'content', &block)
    end

    def cell_bottom(&block)
      content_tag(:div, :class => 'bottom', &block)
    end
  end
end