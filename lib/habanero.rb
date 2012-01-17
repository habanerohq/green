require 'habanero/core_ext'

module Habanero
  mattr_accessor :autoload_blacklist

  def self.table_name_prefix
    'habanero_'
  end
end
