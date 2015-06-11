# encoding: utf-8

class MainNewsStoryImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  #todo
  # storage :file
  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :large do
    process :resize_to_fit => [800, 800]
  end

  version :medium do
    process :resize_to_fit => [333, 333]
  end

  version :small do
    process :resize_to_fit => [125, 125]
  end


  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
