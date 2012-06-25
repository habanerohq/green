require 'carrierwave/orm/activerecord'

module Tabasco
  module PictureTraitGraft
    extend ActiveSupport::Concern

    def adapt(klass)
      klass.send :mount_uploader, column_name.to_sym, GalleryUploader
    end
  end
end
