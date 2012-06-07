module Habanero
  module Graft
    extend ActiveSupport::Concern
    
    def best_id
      respond_to?(:slug) ? slug : id
    end

    def to_s_qual
      to_s
    end
  end
end
