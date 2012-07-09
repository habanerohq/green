module Tabasco
  class GalleryUploader < ::CarrierWave::Uploader::Base
    include CarrierWave::RMagick

    storage :file

    def extension_white_list
      %w(jpg jpeg gif png)
    end

    version :usual do
      process :resize_to_fit => [960, 960]
    end

    version :half, :from_version => :usual do
      process :resize_to_fit => [480, 480]
    end

    version :thumb, :from_version => :half do
      process :resize_to_fill => [240, 240]
    end

    version :small_thumb, :from_version => :thumb do
      process :resize_to_fill => [80, 80]
    end

  end
end