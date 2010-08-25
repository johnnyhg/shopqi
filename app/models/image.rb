# encoding: utf-8
require 'carrierwave/orm/mongoid'
class Image
  include Mongoid::Document
  include Mongoid::Timestamps

  field :width, :type => Integer, :default => 255
  field :height, :type => Integer, :default => 44

  embeds_many :backgrounds
  embeds_many :words

  #mongoid出于性能上的考虑不会触发子记录的callback，导致carrierwave无法将生成图片的路径写入，这里需要手动触发
  #http://github.com/durran/mongoid/issues/issue/35
  #http://github.com/durran/mongoid/issues/closed/#issue/160
  before_create :trigger_embed_callback

  def trigger_embed_callback
    self.backgrounds.each do |background|
      background.run_callbacks :save
    end
  end

  after_save :render

  #生成图片
  def render
    magick = MiniMagick::Image.from_file(blank)
    magick.combine_options do |c|
      c.resize "#{width}x#{height}!"
      # 基准坐标：左上角
      c.gravity 'NorthWest'
      # 背景
      backgrounds.each do |background|
        c.draw "image over #{background.x},#{background.y},0,0 '#{background.file.path}'"
      end
      # 文字
      words.each do |word|
        size = word.attributes['font-size'].to_i
        c.font font_path(word.font)
        #undefined size??
        #c.pointsize word.font-size
        c.pointsize size
        #c.weight :bold
        #c.stroke 'black'
        c.fill word.color
        if word.background
          c.draw "roundrectangle #{word.x - 5}, #{word.y}, #{word.text.size * size + 5}, #{height}, 5, 5" if word.background
          #有背景，则前景颜色改为白色
          c.fill 'white'
        end
        c.draw "text #{word.x},#{word.y} '#{word.text}'"
      end
    end
    magick.write path
  end

  def font_path(font)
    "#{Rails.root}/public/images/logo/#{font}.ttf"
  end

  def blank
    "#{Rails.root}/public/images/logo/blank.png"
  end

  def path
    "#{Rails.root}/public/images/logo/#{id}.png"
  end

  def url
    "/images/logo/#{id}.png?#{self.updated_at.to_i}"
  end
end

#背景图片
class Background
  include Mongoid::Document
  
  field :x, :type => Integer, :default => 0
  field :y, :type => Integer, :default => 0
  mount_uploader :file, ImageUploader

  #页面背景保存前的序号
  attr_accessor :tmp_id

  embedded_in :image, :inverse_of => :backgrounds
end

#文字
class Word
  include Mongoid::Document

  field :x, :type => Integer
  field :y, :type => Integer
  field :font
  field 'font-size'
  field :color
  field :text
  field :background

  #页面文字保存前的ID
  attr_accessor :tmp_id

  #字体:微软雅黑,华康海报体W12,方正少女体,方正卡通,柳叶
  #validates_inclusion_of :font, :in => %w( yahei haibao fzsn katong liuye)
  #背景形状#:带边角正方形
  validates_inclusion_of :background, :in => %w( roundrectangle )

  embedded_in :image, :inverse_of => :words
end
