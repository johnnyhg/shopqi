require 'dragonfly'

app = Dragonfly[:images]

# Get the config from config/mongoid.yml
db = YAML.load_file(Rails.root.join('config/mongoid.yml'))[Rails.env]['database']
host = YAML.load_file(Rails.root.join('config/mongoid.yml'))[Rails.env]['host']
port = YAML.load_file(Rails.root.join('config/mongoid.yml'))[Rails.env]['port']


# Configure to use ImageMagick, Rails defaults, and the Mongo data store
app.configure_with(:imagemagick)

app.configure_with(:rails) do |c|
  c.datastore = Dragonfly::DataStorage::MongoDataStore.new(:database => db,:port => port,:host => host)
end

# Allow all mongoid models to use the macro 'image_accessor'
app.define_macro_on_include(Mongoid::Document, :image_accessor)

