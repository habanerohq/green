module Habanero
  class Sorbet < ActiveRecord::Base
  end
end

Habanero::Sorbet.class_eval { include Habanero::SorbetIce }
Habanero::Sorbet.namespaced('Habanero').where(:name => 'Sorbet').first.try(:adapt) if Habanero::Sorbet.table_exists?
