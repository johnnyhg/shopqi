# language: zh-CN
功能: 管理网店布局
  为了调整网店布局
  作为用户
  可以直接在网页上修改网店热门分类
  
  @focus
  @javascript
  场景大纲: 添加热门分类
    假如我已经以用户名saberma@shopqi.com登录
    假如系统有以下热门分类:
      |女装|女新品装     |季末特惠   |吊带/背心29元|短袖T恤39元|
      |男装|男新品装     |短袖T恤    |棉麻休闲裤   |水洗POLO   |
      |童装|大童(6岁以上)|小童(1-6岁)|婴儿装       |亲子装     |
      |鞋  |男鞋         |女鞋       |童鞋         |透气休闲鞋 |
      |配饰|女包(34款)   |帽子(38款) |男款皮带     |女款皮带   |
    当我访问网店布局管理页面
    * 把鼠标移到女装
    * 点击编辑
    * 页面会显示操作表单
    假如我点击<按钮>
    * 页面会显示操作表单
    当我输入名称为男鞋
    * 输入链接地址为/shoes
    而且点击保存
    * 应该能看到男鞋
    而且男鞋显示在女装之<位置>
  例子:
    |      按钮    | 位置 |
    | <<在其上添加 |  上  |
    | 在其下添加>> |  下  |
  
  @javascript
  场景: 修改热门分类
    假如我已经以用户名saberma@shopqi.com登录
    假如系统有以下热门分类:
      |女装|女新品装     |季末特惠   |吊带/背心29元|短袖T恤39元|
      |男装|男新品装     |短袖T恤    |棉麻休闲裤   |水洗POLO   |
      |童装|大童(6岁以上)|小童(1-6岁)|婴儿装       |亲子装     |
      |鞋  |男鞋         |女鞋       |童鞋         |透气休闲鞋 |
      |配饰|女包(34款)   |帽子(38款) |男款皮带     |女款皮带   |
    当我访问网店布局管理页面
    * 把鼠标移到女装
    * 点击编辑
    那么页面会显示操作表单
    当我输入名称为淑女
    * 输入链接地址为/girl
    而且点击保存
    那么在热门分类那里应该看不到女装
    * 应该能看到淑女
    * 把鼠标移到女新品装
    * 点击编辑
    那么页面会显示操作表单
    当我输入名称为仿皮夹克
    * 输入链接地址为/fake
    而且点击保存
    那么在热门分类那里应该看不到女新品装
    * 应该能看到仿皮夹克
  
  @javascript
  场景: 删除热门分类
    假如我已经以用户名saberma@shopqi.com登录
    假如系统有以下热门分类:
      |女装|女新品装     |季末特惠   |吊带/背心29元|短袖T恤39元|
      |男装|男新品装     |短袖T恤    |棉麻休闲裤   |水洗POLO   |
      |童装|大童(6岁以上)|小童(1-6岁)|婴儿装       |亲子装     |
      |鞋  |男鞋         |女鞋       |童鞋         |透气休闲鞋 |
      |配饰|女包(34款)   |帽子(38款) |男款皮带     |女款皮带   |
    当我访问网店布局管理页面
    * 把鼠标移到女新品装
    * 点击编辑
    那么页面会显示操作表单
    当我点击删除
    那么在热门分类那里应该看不到女新品装
    * 把鼠标移到女装
    * 点击编辑
    那么页面会显示操作表单
    当我点击删除
    那么在热门分类那里应该看不到女装
    那么在热门分类那里应该看不到季末特惠
