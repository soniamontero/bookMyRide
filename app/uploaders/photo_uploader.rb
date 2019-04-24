class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  version :rides_card do
    resize_to_fill 600, 600
  end
end
