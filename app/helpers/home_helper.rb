module HomeHelper
  #是否在首页
  def is_home?
    action_name == 'index' 
  end
end
