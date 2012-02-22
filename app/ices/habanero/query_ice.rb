module Habanero
  module QueryIce
    extend ActiveSupport::Concern

    included do
      validates :sorbet, :presence => true
    end

    def evaluate(params = {})
      chain = sorbet.klass.unscoped
      query = conditions.reduce(chain) { |q, c| c.apply(q, params[:q]) }
    end
  end
end
