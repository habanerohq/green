module Tabasco  
  module TraitsHelper    

    def format_tabasco_picture_trait(target, trait)
      trait_span(trait) do
        content_tag(:p, image_tag(target.send "#{trait.column_name}_url")) <<
        content_tag(:p, target.send(trait.method_name))
      end
    end

  end
end
