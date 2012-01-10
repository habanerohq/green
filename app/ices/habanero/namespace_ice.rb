module Habanero
  module NamespaceIce
    extend ActiveSupport::Concern
    
    included do
      has_many :sorbets
    end
  end
end