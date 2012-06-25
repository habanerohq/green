require 'carrierwave/orm/activerecord'

module Habanero
  module FileTraitGraft
    extend ActiveSupport::Concern

    def adapt(klass)
      klass.send :mount_uploader, column_name, Habanero::FileUploader
    end
  end
end
