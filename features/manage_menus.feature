# language: zh-CN
功能: 管理网店布局
  为了调整网店布局
  作为用户
  可以直接在网页上修改网店菜单信息
  
  @javascript
  场景大纲: 添加菜单
    假如我已经以用户名saberma@shopqi.com登录
    假如系统有以下菜单:
      |首页|男包|女包|真皮|数码包|旅行包|
    当我访问网店布局管理页面
    * 把鼠标移到男包
    * 点击编辑
    那么页面会显示操作表单
    假如我点击<按钮>
    当我输入名称为男鞋
    * 输入链接地址为/shoes
    而且点击保存
    * 应该能看到男鞋
    而且男鞋显示在男包之<位置>
  例子:
    |      按钮    | 位置 |
    | <<在其前添加 |  前  |
    | 在其后添加>> |  后  |
  
  @javascript
  场景: 修改菜单
    假如我已经以用户名saberma@shopqi.com登录
    假如系统有以下菜单:
      |首页|男包|女包|真皮|数码包|旅行包|
    当我访问网店布局管理页面
    * 把鼠标移到男包
    * 点击编辑
    那么页面会显示操作表单
    当我输入名称为男鞋
    * 输入链接地址为/shoes
    而且点击保存
    * 应该能看到男鞋
  
  @focus
  @javascript
  场景: 删除菜单
    假如我已经以用户名saberma@shopqi.com登录
    假如系统有以下菜单:
      |首页|男包|女包|真皮|数码包|旅行包|
    当我访问网店布局管理页面
    * 把鼠标移到男包
    * 点击编辑
    那么页面会显示操作表单
    当我点击删除
    那么在菜单那里应该看不到男包
  
  #此测试不稳定，会被其他DOM元素的CSS影响，导致测试不通过
  #@focus
  #@javascript
  #场景: 调整顺序
  #  假如系统有以下菜单:
  #    |首页|男装|女装|鞋|配饰|
  #  当我访问网店布局管理页面
  #  而且将男装移至鞋前面
  #  那么男装显示在鞋之前
