require 'carrierwave'

module Tabasco
  class GalleryUploader < ::CarrierWave::Uploader::Base
    storage :file

    def extension_white_list
      %w(jpg jpeg gif png)
    end
  end
end