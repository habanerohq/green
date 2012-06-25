module Habanero
  class FileUploader < ::CarrierWave::Uploader::Base
    storage :file
  end
end
