# encoding: utf-8
#首页顶端导航
class Help
  include Extensions::Base
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::ActsAsSortableTree

  referenced_in :store

  field :name
  field :content
  field :url
end
