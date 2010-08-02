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

    when /the new user page/
      new_user_path


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
      '#nav'
    end
  end
end

World(NavigationHelpers)
