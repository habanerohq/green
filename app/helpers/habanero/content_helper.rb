module Habanero
  module ContentHelper
    def feature_content(feature)
      to_content(feature, feature.body)
    end

    def to_content(feature, content)
      if bf = feature.body_format
        self.send("to_#{bf.abbreviation}_content", content)
      else
         @placement.no_html? ? content : content.try(:html_safe)
      end
    end

    def to_markdown_content(content)
      RDiscount.new(content || '').to_html
    end
    
    def html_enabled_submit_class
      @placement.no_html? ? '' : 'wymupdate'
    end

    def html_enabled_input_class
      'wymeditor'
    end
  end
end