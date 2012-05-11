module Habanero
  module SiteGraft
    extend ActiveSupport::Concern

    module ClassMethods
      def current
        @current ||= self.first # need to be able to configure this!
      end
    end
  end
end
