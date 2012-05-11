require 'habanero/core_ext'

module Habanero
  autoload :DerivedTrait, 'habanero/derived_trait'
  autoload :Observer,     'habanero/observer'

  def self.table_name_prefix
    'habanero_'
  end
end
