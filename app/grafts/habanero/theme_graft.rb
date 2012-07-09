module Habanero
  module ThemeGraft
    extend ActiveSupport::Concern
    
    def to_sass
      theme_traits.map do |t|
        if v = self.send(t.method_name)
          "$#{t.name.gsub(/\s/, '_').camelize(:lower)}: #{v};"
        end        
      end.compact.join(' ')
    end
    
    protected
    
    def theme_traits
      _variety.all_traits.reject { |t| t.name.downcase.in?('name', 'slug', 'super theme', 'brand') } # brittle!
    end
  end
end
