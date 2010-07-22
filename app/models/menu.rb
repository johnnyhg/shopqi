# encoding: utf-8
# 首页顶端菜单
class Menu
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActsAsList::Mongoid 

  field :name, :default => '空白菜单'
  field :url

  #排序
  field :pos, :type => Integer
  acts_as_list :column => :pos
  #页面传递的参数，用于新增时指明其所在的参照数哪个位置(前或后)
  attr_accessor :neighbor, :direct

  embedded_in :page, :inverse_of => :menus

  #一定要初始化pos
  after_create :init_pos

  def init_pos
    page.menus.init_list!
    if direct
      move(direct.to_sym => page.menus.find(neighbor))
      page.save
    end
  end

  #生成sprite图片
  def self.sprite(page)
    menus = page.sorted_menus

    unit_width = 87
    width = menus.size * unit_width
    height = 84
    font_size = 18

    front_color = '#ACACAC'
    hover_color = '#AA6D00'

    magick = MiniMagick::Image.from_file("#{Rails.root}/public/images/logo/blank.png")
    magick.combine_options do |c|
      #基准坐标：左上角
      c.gravity 'NorthWest'
      c.resize "#{width}x#{height}!"

      #背景色
      c.fill :black
      c.draw "rectangle 0, 0, #{width}, #{height}"

      menus.each_with_index do |menu, index|
        #menu.name = menu.name.insert(1, '　') if menu.name.size == 2
        c.font "#{Rails.root}/public/images/logo/yahei.ttf" 
        c.pointsize font_size
        c.fill front_color
        x = index * unit_width + (unit_width - menu.name.size * font_size) / 2
        y = (height / 2 - font_size) / 2 - 6
        c.draw "text #{x},#{y} '#{menu.name}'"

        # 绘制虚线
        # 参考http://www.imagemagick.org/Usage/draw/
        line_x = (index + 1) * unit_width - 1
        c.fill :none
        c.stroke front_color
        c.draw "stroke-dasharray 1 3 path 'M #{line_x},0 L #{line_x},#{height / 2}'" unless index == menus.size - 1 
        c.stroke :none 

        # 鼠标悬停文字
        c.fill hover_color
        y += height / 2
        c.draw "text #{x},#{y} '#{menu.name}'"

        # 绘制虚线
        c.fill :none
        c.stroke front_color
        c.draw "stroke-dasharray 1 3 path 'M #{line_x},#{height / 2} L #{line_x},#{height}'" unless index == menus.size - 1 
        c.stroke :none 
      end
    end
    magick.write page.menu_sprite_path
  end
end
