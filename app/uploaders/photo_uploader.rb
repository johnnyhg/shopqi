# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support
  #     include CarrierWave::RMagick
  #     include CarrierWave::ImageScience
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader
  #storage :file
  #     storage :s3

  # Override the directory where uploaded files will be stored
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "images/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded
  def default_url
    "/images/fallback/product/#{version_name}.png"
  end

  # Process files as they are uploaded.
  #     process :scale => [200, 300]
  #
  #     def scale(width, height)
  #       # do something
  #     end

  # Create different versions of your uploaded files
  # 显示在产品详情页中的缩略图
  version :icon do
    process :resize_to_fill => [60, 60]
  end

  # 显示在产品列表页中的缩略图
  version :small do
    #mbaobao
    #process :resize_to_fill => [185, 185]
    process :resize_to_fill => [175, 175]
  end

  # 显示在产品详情页中的图片
  version :middle do
    process :resize_to_fill => [418, 418]
  end

  # 显示在产品详情页中的放大镜图片
  version :big do
    process :resize_to_fill => [1024, 1024]
  end

  version :accordion do
    process :resize_to_fill => [220, 118]
  end

  # Add a white list of extensions which are allowed to be uploaded,
  # for images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files
  #     def filename
  #       "something.jpg" if original_filename
  #     end

end
