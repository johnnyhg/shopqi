$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

MODELS = File.join(File.dirname(__FILE__), "models")
$LOAD_PATH.unshift(MODELS)

require 'rubygems'
require "bundler"
Bundler.setup

require "mongoid"
require "acts_as_list_mongoid"
require "rspec"

Mongoid.configure do |config|
  name = "sortable_test"
  config.master = Mongo::Connection.new.db(name)
end

require File.join(File.dirname(__FILE__), "..", "lib/sortable.rb")
Dir[ File.join(MODELS, "*.rb") ].sort.each { |file| require File.basename(file) }

Rspec.configure do |config|
  config.after :suite do
    Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end
end
