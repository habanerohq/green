module Habanero
  class Sorbet < ActiveRecord::Base
  end
end

Habanero::Sorbet.class_eval { include Habanero::SorbetGraft }

if Habanero::Sorbet.table_exists?
  Habanero::Sorbet.branded('Habanero').where(:name => 'Sorbet').first.try(:adapt)
  Habanero::Sorbet.class_attribute :_sorbet
  Habanero::Sorbet._sorbet = Habanero::Sorbet.branded('Habanero').where(:name => 'Sorbet').first
end
