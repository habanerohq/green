module Jalapeno
  module AuthenticationDeploymentGraft
    extend ActiveSupport::Concern

    def active_modules
      _variety.traits.
        map { |t| t.column_name.to_sym if t.type == 'Habanero::TrueFalseTrait' and self.send(t.column_name) }.
        compact
    end  
  end
end
