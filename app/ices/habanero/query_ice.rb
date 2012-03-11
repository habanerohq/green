module Habanero
  module QueryIce
    extend ActiveSupport::Concern

    included do
      validates :sorbet, :presence => true
    end

    def evaluate(params = {})
      chain = klass.unscoped
      query = conditions.reduce(chain) { |q, c| c.apply(q, params[:q]) }
    end
    
    def klass
      sorbet.klass
    end
  end
end
