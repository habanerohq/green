module Habanero
  module ConditionGraft
    extend ActiveSupport::Concern

    included do
     validates_inclusion_of :predicate, :in => %w(eq not_eq matches does_not_match lt lteq gt gteq in not_in)
    end

    def apply_to(chain, params = {})
      params = (params || {}).stringify_keys

      column = trait.arel_column
      self.value = params["#{trait.method_name}"] if params["#{trait.method_name}"] 
      self.value = "%#{value}%" if predicate.include?('match')
      chain = trait.apply_inclusions(chain)
      chain.where(column.send(predicate, value))
    end
    
    def to_s
      "#{trait} #{predicate} '#{value}'"
    end
  end
end
