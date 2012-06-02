module Habanero
  class Variety < ActiveRecord::Base
    include Habanero::Graft
  end
end

Habanero::Variety.class_eval { include Habanero::VarietyGraft }

Green.germinate_model('Habanero', 'Variety')