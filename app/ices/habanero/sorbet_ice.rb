module Habanero
  module SorbetIce
    extend ActiveSupport::Concern

    included do
      belongs_to :namespace
      validates_presence_of :namespace

      has_many :ingredients
    end
  end
end