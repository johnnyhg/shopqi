# encoding: utf-8
require 'carrierwave/orm/mongoid'

class Page
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  validates_uniqueness_of :name

  embeds_one :logo
  embeds_many :navs

  before_create :create_logo

  #必需有Logo
  def create_logo
    self.logo = Logo.new
  end

  def sorted_navs
    navs.sort {|x, y| x.pos <=> y.pos}
  end

  def self.mbaobao
    where(:name => :mbaobao).first
  end
end

#首页Logo
class Logo
  include Mongoid::Document
  embedded_in :page, :inverse_of => :logo

  field :url, :default => '/images/logo/default.gif'

  #在线文字合成ID
  field :image_id
  #mount_uploader :image, ImageUploader
end
