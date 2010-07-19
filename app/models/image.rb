# encoding: utf-8
class Image
  include Mongoid::Document
  include Mongoid::Timestamps

  field :width, :type => Integer
  field :height, :type => Integer

  embeds_many :words

  after_save :render

  #生成图片 参数说明:http://www.imagemagick.org/Usage/
  def render
    unless words.empty?
      magick = MiniMagick::Image.from_file(blank)
      magick.combine_options do |c|
        c.resize "#{width}x#{height}!"
        #基准坐标：左上角
        c.gravity 'NorthWest'
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
      Page.mbaobao.logo.update_attributes :url => url, :image_id => id
    end
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
    "/images/logo/#{id}.png"
  end
end

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
