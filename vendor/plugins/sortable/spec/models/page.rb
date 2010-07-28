# encoding: utf-8
# 首页
class Page
  include Mongoid::Document
  include Mongoid::Sortable
  sortable :navs
end
