# coding: utf-8
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /首页/
      '/'
    when /the new category page/
      new_category_path

    when /the new hot page/
      new_hot_path

    when /在线文字图片合成/
      new_image_path

    when /the new page page/
      new_page_path

    when /网店布局管理/
      page_path
    when /the new product page/
      new_product_path
    when /工作平台/
      user_root_path
    when /(.+)分类商品列表页面/
      name = page_name.match(/(.+)分类商品列表页面$/)[1]
      category_products_path(:category_id => Category.where(:name => name).first.id)


    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end

  def scope_to(scope_name)
    case scope_name
    when /菜单/
      '#menus'
    when /热门分类/
      '.hots'
    else
      scope_name
    end
  end
end

World(NavigationHelpers)
