module Habanero
  class Namespace < ActiveRecord::Base
  end
end

Habanero::Namespace.class_eval { include Habanero::NamespaceIce }
Habanero::Sorbet.namespaced('Habanero').where(:name => 'Namespace').first.try(:adapt) if Habanero::Sorbet.table_exists?
