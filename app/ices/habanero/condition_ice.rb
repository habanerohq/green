module Habanero
  module ConditionIce
    extend ActiveSupport::Concern

    included do
     validates_inclusion_of :predicate, :in => %w(eq not_eq matches does_not_match lt lteq gt gteq in not_in)
    end

    def apply(chain, params = {})
      params = (params || {}).stringify_keys

      column = ingredient.sorbet.klass.arel_table[ingredient.column_name]
      chain.where(column.send(predicate, params["#{id}"].present? ? params["#{id}"] : value))
    end
  end
end
