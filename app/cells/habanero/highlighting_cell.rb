module Habanero
  class HighlightingCell < Habanero::VarietyCell
    def edit(options)
      super(options) do
        @target.highlighted_traits.destroy_all

        link_traits
      end
    end

    def new(options)
      super(options) do
        link_traits
      end
    end
    
    protected
    
    def link_traits
      params[:traits].each_with_index do |oid, i|
        TraitHighlight.create(
          :highlighter => @target,
          :trait_id => oid,
          :highlighter_position => i + 1
        )
      end
    end
  end
end
