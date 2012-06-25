require 'carrierwave/orm/activerecord'

module Tabasco
  module PictureTraitGraft
    extend ActiveSupport::Concern

    def adapt(klass)
      klass.send :mount_uploader, column_name, GalleryUploader
    end
  end
end
