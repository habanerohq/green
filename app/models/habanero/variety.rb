module Habanero
  class Variety < ActiveRecord::Base
    include Habanero::Graft
  end
end

Habanero::Variety.class_eval { include Habanero::VarietyGraft }

if Habanero::Variety.table_exists?
  Habanero::Variety.branded('Habanero').where(:name => 'Variety').first.try(:adapt)
  Habanero::Variety.class_attribute :_variety
  Habanero::Variety._variety = Habanero::Variety.branded('Habanero').where(:name => 'Variety').first
end
