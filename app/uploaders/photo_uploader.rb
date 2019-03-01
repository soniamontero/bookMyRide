class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  version :rides_card do
    resize_to_fit 290, 290
  end
end
