CarrierWave.configure do |config|
  config.grid_fs_database = 'carrierwave'
  config.storage = :grid_fs

  config.grid_fs_connection = Mongoid.database

  # Storage access url
  config.grid_fs_access_url = "/gridfs"
end
