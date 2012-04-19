module Habanero
  module GraderGraft
    extend ActiveSupport::Concern

    included do
      validates :variety, :presence => true
    end

    def evaluate(params = {})
      chain = klass.unscoped
      grader = conditions.reduce(chain) { |q, c| c.apply_to(q, params[:q]) }
    end
    
    def klass
      variety.klass
    end
  end
end
