module Habanero
  module ConditionIce
    extend ActiveSupport::Concern

    included do
     validates_inclusion_of :predicate, :in => %w(eq not_eq matches does_not_match lt lteq gt gteq in not_in)
    end

    def apply_to(chain, params = {})
      params = (params || {}).stringify_keys

      column = ingredient.sorbet.klass.arel_table[ingredient.column_name]
      self.value = params["#{ingredient.method_name}"] if params["#{ingredient.method_name}"] 
      self.value = "%#{value}%" if predicate.include?('match')
      chain.where(column.send(predicate, value))
    end
  end
end
