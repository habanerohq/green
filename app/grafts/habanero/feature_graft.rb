module Habanero
  module FeatureGraft
    extend ActiveSupport::Concern

    attr_accessor :search
    
    module ClassMethods
      def cell_type
        name.gsub('Feature', '')
      end
    end
    
    def traits
      highlighter ? highlighter.traits : best_variety.try(:primary_traits)
    end

    def translators
      @prompts || traits
    end
    
    def translate_search(data)
      self.search = Habanero::Search.new(data, translators)
      g = grader || Habanero::Grader.new(:variety => variety)
      search.translate(g.evaluate)
    end

    def cell_type
      self.class.cell_type
    end
    
    protected
    
    def best_variety
      variety || grader.try(:variety)
    end
  end
end
