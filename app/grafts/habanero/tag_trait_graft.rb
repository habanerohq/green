module Habanero
  module TagTraitGraft
    extend ActiveSupport::Concern

    def adapt(klass)
      klass.send((ordered? ? :acts_as_ordered_taggable_on : :acts_as_taggable_on), method_name)
    end
  end
end

