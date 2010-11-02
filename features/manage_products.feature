# language: zh-CN
功能: 管理产品
  为了向访问者展示产品
  作为用户
  可以添加、修改商品
  
  @javascript
  场景: 上传商品图片
    假如我已经以用户名saberma@shopqi.com登录
    当我点击添加商品
    而且将图片public/images/logo.jpg上传
    那么缩略图应该能显示
  
  @javascript
  场景: 添加商品
    假如我已经以用户名saberma@shopqi.com登录
    * 点击添加商品
    当我输入名称为iphone
    当我输入价格为99
    而且点击保存
    那么我应该能看到添加成功

  @javascript
  场景: 显示商品列表
    假如我已经以用户名saberma@shopqi.com登录
    假如系统有以下商品分类:
      |男装|      |          |
      |    |衬衫  |          |
      |    |      |牛津纺衬衫|
      |    |      |商务衬衫  |
      |    |      |休闲衬衫  |
      |    |POLO衫|          |
      |    |针织衫|          |
      |    |      |针织背心  |
      |    |      |长袖针织衫|
      |    |外套  |          |
      |    |      |夹克      |
      |    |      |西服      |
      |    |      |卫衣      |
      |    |      |风衣      |
      |    |      |棉服      |
      |女装|      |          |
      |    |百变衫|          |
      |    |BRA-T |          |
      |    |打底裤|          |
      |    |裙子  |          |
    * 网店有以下商品:
      |名称              |市场价格|价格|分类|
      |个性背带格子衬衫  |298     |59  |男装|
      |自由舒爽棉麻衬衫  |388     |59  |衬衫|
      |白色剪花抹胸裙    |599     |199 |裙子|
      |甜美荷叶边丝带衬衫|299     |99  |女装|
    当我访问衬衫分类商品列表页面
    那么我应该能看到自由舒爽棉麻衬衫
    * 应该看不到个性背带格子衬衫

  @focus
  @javascript
  场景: 购买商品
    假如我已经以用户名saberma@shopqi.com成功注册
    #而且我已经以会员ben@shopqi.com成功注册
    假如系统有以下商品分类:
      |男装|      |          |
      |    |衬衫  |          |
      |    |      |牛津纺衬衫|
      |    |      |商务衬衫  |
      |    |      |休闲衬衫  |
      |    |POLO衫|          |
      |    |针织衫|          |
      |    |      |针织背心  |
      |    |      |长袖针织衫|
      |    |外套  |          |
      |    |      |夹克      |
      |    |      |西服      |
      |    |      |卫衣      |
      |    |      |风衣      |
      |    |      |棉服      |
      |女装|      |          |
      |    |百变衫|          |
      |    |BRA-T |          |
      |    |打底裤|          |
      |    |裙子  |          |
    * 网店有以下商品:
      |名称              |市场价格|价格|分类|
      |个性背带格子衬衫  |298     |59  |男装|
      |自由舒爽棉麻衬衫  |388     |59  |衬衫|
      |白色剪花抹胸裙    |599     |199 |裙子|
      |甜美荷叶边丝带衬衫|299     |99  |女装|
    当我访问个性背带格子衬衫商品详情页面
    * 我点击立即购买
    那么我应该能看到个性背带格子衬衫
    当我点击去结算
    #而且输入以下内容:
    #  |用户名|ben@shopqi.com |
    #  |密　码|666666         |
    #当我点击登录
    而且输入以下内容:
      |请填写您的Email地址：|saberma@shopqi.com |
      |请设定密码：         |666666             |
      |请再次输入设定密码： |666666             |
    当我点击完成
    那么我应该能看到提交订单
    当我点击提交订单
    那么页面应该显示以下订单列表:
      |订单号       |订单日期           |总价|状态|
      |2010010100001|2010-01-01 10:10:10|59.0|0   |
