# encoding: utf-8

class SliderImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # storage :fog
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :large do
    process :resize_to_fill => [900, 300]
  end

  version :small do
    process :resize_to_fill => [225, 75]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
