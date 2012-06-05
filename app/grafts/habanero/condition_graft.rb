module Habanero
  module ConditionGraft
    extend ActiveSupport::Concern

    def apply_to(chain, params = {})
      params = (params || {}).stringify_keys

      column = trait.arel_column
      self.value = params["#{trait.method_name}"] if params["#{trait.method_name}"] 
      self.value = "%#{value}%" if predicate.abbreviation.include?('match')
      self.value = value.split('; ') if predicate.abbreviation.include?('in')
      chain = trait.apply_inclusions(chain)
      chain.where(column.send(predicate.abbreviation, value))
    end
    
    def to_s
      "#{trait} #{predicate} '#{value}'"
    end
  end
end
