module HomeHelper
  #首页内容区显示为灰色
  def wrapper_class
    is_home? ? :bhome : ''
  end

  #是否在首页
  def is_home?
    action_name == 'index' 
  end
end
