module Habanero
  class Sorbet < ActiveRecord::Base
  end
end

Habanero::Sorbet.class_eval { include Habanero::SorbetIce }

if Habanero::Sorbet.table_exists?
  Habanero::Sorbet.namespaced('Habanero').where(:name => 'Sorbet').first.try(:adapt)
  Habanero::Sorbet.class_attribute :_sorbet
  Habanero::Sorbet._sorbet = Habanero::Sorbet.namespaced('Habanero').where(:name => 'Sorbet').first
end
