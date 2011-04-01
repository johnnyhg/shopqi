# encoding: utf-8

# 注意通过生成器rails g uploader image生成的文件为app/uploaders/image.rb，rails3无法正确加载，文件名应改为image_uploader.rb
class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  # Provide a default URL as a default if there hasn't been a file uploaded
  def default_url
    "/images/fallback/" + [:image, "default.gif"].compact.join('_')
  end

end
