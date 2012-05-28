module Habanero
  module Graft
    extend ActiveSupport::Concern

    def to_s_qual
      to_s
    end
  end
end
