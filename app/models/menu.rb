# encoding: utf-8
# 首页顶端菜单
class Menu
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Sortable
  sortable_belong_to :page

  field :name
  field :url

  #生成sprite图片
  def self.sprite(page)
    menus = page.sorted_menus

    bg_path = "#{Rails.root}/public/templates/#{User.current.store.template}/menu_bg.png" 
    bg_hover_path = "#{Rails.root}/public/templates/#{User.current.store.template}/menu_bg_hover.png" 

    bg = MiniMagick::Image.from_file(bg_path)

    unit_width = bg[:width]
    width = menus.size * unit_width
    height = bg[:height] * 2
    font_size = 14

    font_color = '#000'
    font_hover_color = '#fff'

    magick = MiniMagick::Image.from_file("#{Rails.root}/public/images/logo/blank.png")
    magick.combine_options do |c|
      #基准坐标：左上角
      c.gravity 'NorthWest'
      c.resize "#{width}x#{height}!"

      menus.each_with_index do |menu, index|

        # 绘制背景图
        x0 = index * unit_width
        y0 = 0
        c.draw "image over #{x0},#{y0},0,0 '#{bg_path}'"

        # 文字
        c.font "#{Rails.root}/public/images/logo/yahei.ttf" 
        c.pointsize font_size
        c.fill font_color

        x = index * unit_width + (unit_width - menu.name.size * font_size) / 2
        y = (height / 2 - font_size) / 2
        c.draw "text #{x},#{y} '#{menu.name}'"

        # 绘制悬停背景图
        y0 = height / 2
        c.draw "image over #{x0},#{y0},0,0 '#{bg_hover_path}'"

        # 鼠标悬停文字
        c.fill font_hover_color
        y += height / 2
        c.draw "text #{x},#{y} '#{menu.name}'"
      end
    end
    magick.write page.menu_sprite_path
  end
end
