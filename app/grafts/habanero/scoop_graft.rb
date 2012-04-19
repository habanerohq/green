module Habanero
  module ScoopGraft
    extend ActiveSupport::Concern

    attr_accessor :search
    
    def variety
      query.try(:variety)
    end
    
    def ingredients
      mask ? mask.ingredients : variety.try(:primary_ingredients)
    end

    def translators
      @prompts || ingredients
    end
    
    def translate_search(data)
      self.search = Habanero::Search.new(data, translators)      
      search.translate(query.evaluate)
    end
    
    module ClassMethods
      def cell_type
        name.gsub('Scoop', '')
      end
    end

    def cell_type
      self.class.cell_type
    end
  end
end
