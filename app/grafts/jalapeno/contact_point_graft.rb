module Jalapeno
  module ContactPointGraft
    extend ActiveSupport::Concern
    
    def to_s
      [value, notes].compact.join(' - ')
    end
  end
end
