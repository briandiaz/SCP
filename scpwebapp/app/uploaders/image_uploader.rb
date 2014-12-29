# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  
  storage :file
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :small do
    process :resize_to_fit => [50, 50]
  end

  version :medium do
    process :resize_to_fit => [200, 200]
  end

  version :large do
    process :resize_to_fit => [500, 500]
  end
  
end
