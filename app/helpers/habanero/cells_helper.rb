module Habanero
  module CellsHelper
    include PlacementsHelper
    include TraitsHelper
    include GridsHelper
    include VarietiesHelper
    include NavigationHelper

    def cell_div(options={}, &block)
      options.reverse_merge!(:id => @feature.name.idify, :class => "cell #{cell_id.idify} #{@placement.template}")
      content_tag(:div, options, &block)
    end

    def cell_id
      controller.class.name.gsub(/cell$/i, '').attrify
    end

    def cell_title(title, &block)
      content_tag(:div, :class => 'title') do
        h(2) {title.to_s} << (block.present? ? with_output_buffer(&block) : '')
      end
    end

    def h(offset, &block)
      level = "h#{@feature.level + offset}"
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
    
    def list_label(target)
      if @label_trait.present?
        format_trait(target, @label_trait)
      else
        target.to_s
      end
    end
    
    def list_link(target)
      if @label_trait.present? and @label_trait.relation == 'belongs_to'
        value_for(target, @label_trait)
      else
        target
      end
    end
  end
end
