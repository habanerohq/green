module Habanero
  class Namespace < ActiveRecord::Base
  end
end

Habanero::Namespace.class_eval { include Habanero::NamespaceIce }

if Habanero::Sorbet.table_exists?
  Habanero::Sorbet.namespaced('Habanero').where(:name => 'Namespace').first.try(:adapt)
  Habanero::Namespace.class_attribute :_sorbet
  Habanero::Namespace._sorbet = Habanero::Sorbet.namespaced('Habanero').where(:name => 'Namespace').first
end
