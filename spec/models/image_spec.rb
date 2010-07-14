# encoding:utf-8
require 'spec_helper'

describe Image do

  it "should render a image" do
    image = Image.create :width => 251, :height => 44
    image.words.create :x => 5, :y => 0, :font => :fzsn, :size => 28, :color => '#E60012', :text => '麦包包', :background => :roundrectangle
    image.words.create :x => 110, :y => 5, :font => :haibao, :size => 20, :color => '#E60012', :text => '买包包? 麦包包!'

    unless image.words.empty?
      magick = MiniMagick::Image.from_file(blank)
      magick.combine_options do |c|
        c.resize "#{image.width}x#{image.height}!"
        #基准坐标：左上角
        c.gravity 'NorthWest'
        image.words.each do |word|
          c.font font_path(word.font)
          c.pointsize word.size
          #c.weight :bold
          #c.stroke 'black'
          c.fill word.color
          if word.background
            c.draw "roundrectangle #{word.x - 5}, #{word.y}, #{word.text.size * word.size + 5}, #{image.height}, 5, 5" if word.background
            #有背景，则前景颜色改为白色
            c.fill 'white'
          end
          c.draw "text #{word.x},#{word.y} '#{word.text}'"
        end
      end
      magick.write(path(image.id))
    end
    #image.save
    #File.exist?("#{Rails.root}/public/images/logo/#{image.id}.png").should == true
    #FileUtils.rm_f("#{Rails.root}/public/images/logo/#{image.id}.png")
  end


  def font_path(font)
    "#{Rails.root}/public/images/logo/#{font}.ttf"
  end

  def blank
    "#{Rails.root}/public/images/logo/blank.png"
  end

  def path(id)
    "#{Rails.root}/public/images/logo/#{id}.png"
  end
end
