# encoding: utf-8
module StoreInitializer

  @queue = "store_initializer"
  
  def self.perform(id)
    store = Store.find(id)
    #image
    store.logo_image_id = store.images.create(:width => 300, :height => 40).id
    store.telephone_image_id = store.images.create(:width => 190, :height => 50).id
    store.save
    #child
    store.pages.create :name => :homepage
    # 设置虚拟root节点是为了方便子记录调用parent.children.order_method_name排序
    category_root = store.categories.create :name => :invisible

    #虚拟单根节点，方便实际根节点排序
    #分类
    { '男装' => { '衬衫' => %w() },
      '女装' => %w()
    }.each_pair do |key, values|
      category = store.categories.create(:name => key)
      category_root.children << category
      if values.is_a? Hash
        values.each_pair do |value_key, value_values|
          child = store.categories.create(:name => value_key)
          value_values.each do |c|
            child.children << store.categories.create(:name => c)
          end
          category.children << child
        end
      elsif values.is_a? Array
        category.children = values.map{|v| store.categories.create(:name => v)}
      end
    end

    #商品
    [ { :category => store.categories.where(:name => '男装').first, :name => '男装衬衫1', :market_price => 98, :price => 59 },
      { :category => store.categories.where(:name => '男装').first, :name => '男装衬衫2', :market_price => 198, :price => 59 },
      { :category => store.categories.where(:name => '女装').first, :name => '女装衬衫1', :market_price => 99, :price => 99 },
      { :category => store.categories.where(:name => '女装').first, :name => '女装衬衫2', :market_price => 199, :price => 99 },
      { :category => store.categories.where(:name => '女装').first, :name => '女装衬衫3', :market_price => 299, :price => 99 }
    ].each do |attrs|
      store.products.create attrs
    end

    #logo
    store.reload          #fixed:undefined method `id_criteria' for #<Array:0xb21a18c>
    logo = store.logo_image
    logo.words.build(:x => 0, :y => 2, :font => :yahei_bold, 'font-size' => '36px', :color => '#000000', :text => :ShopQi)
    logo.words.build(:x => 143, :y => 0, :font => :yahei_bold, 'font-size' => '36px', :color => '#89060C', :text => '在线商店')
    logo.save

    #telephone
    telephone = store.telephone_image
    telephone.words.build(:x => 80, :y => 5, :font => :yahei, 'font-size' => '12px', :color => '#000000', :text => '订购热线(免长途费)')
    telephone.words.build(:x => 20, :y => 22, :font => :yahei_bold, 'font-size' => '24px', :color => '#89060C', :text => '400 800 8888')
    telephone.save

    #导航
    nav_root = store.navs.create :name => :invisible
    [ { :name => '我的帐户', :url => '/user' },
      { :name => '帮助中心', :url => '/help' }
    ].each do |attributes|
      store.navs.create(attributes.merge(:parent => nav_root))
    end

    #菜单
    menu_root = store.menus.create :name => :invisible
    %w( 首页 男装 女装 ).each do |label|
      store.menus.create(:name => label, :url => '/', :parent => menu_root)
    end
    Menu.sprite store

    #通栏广告
    page = store.pages.homepage
    root = page.containers.roots.first
    fullad_container = store.containers.create( :parent_id => root.id, :type => :fullad ).children.first
    fullad = fullad_container.image
    fullad.words.build(:x => 250, :y => 10, :font => :yahei_bold, 'font-size' => '36px', :color => '#E60012', :text => '全 场 购 物 N 元 免 运 费')
    fullad.save

    #聚焦广告,边栏广告
    root_container = store.containers.create( :parent_id => root.id, :type => :focuses)
    sidead_container = store.containers.create( :parent_id => root_container.id, :type => :sidead)
    store.containers.create( :parent_id => sidead_container.id, :type => :sidead)
    store.containers.create( :parent_id => sidead_container.id, :type => :sidead)

    #热门分类
    root_container = store.containers.create( :parent_id => root.id, :type => :hots)
    accordion = store.containers.create( :parent_id => root_container.id, :type => :products_accordion).children.first
    accordion.category_ids = store.categories.where(:name => '男装').map(&:id)
    accordion.save

    #商品列表
    store.containers.create( :parent_id => root.id, :type => :products_head)
    store.containers.create( :parent_id => root.id, :type => :products)

    help_root = store.helps.create :name => :invisible
    {
      '新手指南' => {
        '注册新用户' => %Q(
您只要通过在本站注册开户，即可成为会员。
注册开户有以下两种途径：
1.网站注册
                                                                                                                                                         (1)进入网站后，点击页面右上方“用户注册”，将出现新页面，在相应提示处输入您的邮箱地址（网站会自动默认注册用户名等同于邮箱地址）、密码（密码设置不要过于简单）、确认密码后点击“完成”即可，注册用户名是唯一的。注册成功后，您可以到网站“我的帐户-个人信息管理”进行个人信息的更新。
(2)在订购过程中注册开户 进入 网站 - 选择您所需要的商品 - 点击放入购物车内 - 将出现新页面 - 在页面右侧点击“注册”进入注册页面。
<a href='/members/sign_in'>点击这里注册新用户&gt;&gt;</a>
2.电话订购注册
在您致电 网站 销售中心订购产品过程中可以通过销售人员为您注册开户。
        ),
        '网站订购流程' => %Q(
 1.挑选商品
 2.放入购物车
 3.选择特惠商品
 选择特惠品，需要您点击特惠品并放入购物车，确认特惠品是否出现在购物车的商品名称中。选择成功后,特惠品和您订购的商品是在一起的。如订单中没有特惠品，则系统默认为放弃特惠品。
 4.进入结算中心
 5.用户登录、注册
 如果您是老顾客,请直接输入用户名和密码登录；如果您是新顾客,请输入您常用的电子邮箱作为用户名,并设定密码,点击“完成”。
 6.填写收货人信息
 7.选择送货方式
 8.选择支付方式
 我们提供的支付方式有：货到付款，网上银行支付，邮局汇款和邮局网汇通汇款。
 9.订单确认
 完成上述所有流程后您可以点击“提交订单”，订单提交以后页面会提示订单号。提交订单表示您已经阅读并接受了网站的“使用条件”。您的订单是您购买产品的意愿表示，我们将通过电子邮件发送给您一封订单确认信。此订单确认信仅确认我们已收到了您的订单，只有当我们向您发出确认短信或电话与您联系得到确认，我们和您之间的订购合同才成立。
        )
      },
      '如何付款/退款' => {
        '支付方式' => %Q(
1．网站为您提供快钱网上支付、网汇通网上支付、财付通账户支付、工行在线支付、招行在线支付、支付宝支付和中国移动手机支付7种在线支付方式，几乎涵盖所有大中型银行发行的银行卡，覆盖率达98％，包括可通过在邮局购买网汇通卡进行网汇通线上支付和充值财付通账户进行支付。 选择在线支付，您的银行卡需要开通相应的在线。

2．银行卡的开通
因各地银行政策不同，建议您在网上支付前拨打所在地银行电话，咨询该行可供网上支付的银行卡种类及开通手续。

3．支付金额上限
目前各银行对于网上支付均有一定金额的限制，由于各银行政策不同，建议您在申请网上支付功能时向银行咨询相关事宜。

4．到款时间
网上支付均是支付成功即到账。若由于网络故障导致您已支付成功的订单未改变订单状态，请您联系我们的客服人员为您解决。

温馨提示：在线支付付款等待期限为24小时。请您在订购成功后24小时内完成支付，否则我们将不会保留您的订单。
        ),
        '如何办理退款' => %Q(
1.发生退货后我们会将款项存入您的虚拟帐户中，以便于下次订购时使用，如您需办理退回，请联系我们的帮助中心，经客服工作人员核实后会为您办理退款。
温馨提示：若由于第三方支付平台或银行原因，造成货款无法及时退回，我们的客服人员会与您联系解决。
2.礼品卡支付金额无法兑换成现金，不能办理现金退款。
        ),
        '发票制度说明' => %Q(
1.如何获得发票?
（1）电话订购时，确认好所需要的产品后，请将您的发票抬头提供给销售人员，发票将随同商品一起送到。
（2）如您在网站订购，请在提交订单前在“您是否需要开具发票”处选择“是”，并填写发票抬头。发票将随商品一起送到。
说明：
（1）网站提供的发票为专用发票，此发票可用作单位报销使用。
（2）一张订单对应一张发票，发票会随每次包裹一同发出。
（3）配送费金额包含在订单发票金额中。
2.网站是否提供增值税发票?
目前，网站还未提供增值税发票。
3.开发票的注意事项
（1）发票金额不能高于订单金额。
                                                                                                                                                         （2）非现金虚拟账户支付的金额和礼品卡支付的金额不开发票。（非现金虚拟账户如：网站的一些促销活动中赠送客户或客户购买的现金卡的金额，已获得过网站的发票的金额。）
例如：订单总金额为500元，使用礼品卡支付100元，选择开具发票后，发票金额为400元，不包含100元礼品卡支付的金额。
4.发票抬头
发票抬头内容不能为空，您可写个人或公司名称。
5.发票内容：产品类型。（网站只可开具内容为指定类型的专用发票。）
6.补发票说明
（1）发票可以补100天之内订购的订单。
（2）补开发票需提供“网站发货单”或详细的订购信息。
（3）请您提供正确的地址，我们会在补开发票后以挂号信方式为您寄出，同时会通过短信或邮件形式告知您，请您注意查收。
（4）收到发票后如发现发票抬头、内容或金额等与您下订单时所填写的项目不符，请先与客服中心联系确认后，将原发票退回网站才予以重开。您可将发票寄至以下地址：  邮编： 科技有限公司收
        )
      },
      '配送方式' => {
        '配送范围及配送时间' => %Q(
        ),
        '配送费收取标准' => %Q(
        )
      },
      '售后服务' => {
        '退换货政策' => %Q(
        ),
        '如何办理退换货' => %Q(
        )
      },
      '帮助中心' => {
        '常见热点问题' => %Q(
        ),
        '联系我们' => %Q(
        ),
        '投诉与建议' => %Q(
        )
      }
    }.each_pair do |key, values|
      help = store.helps.create(:name => key, :parent => help_root)
      values.each_pair do |v_key, v_value|
        store.helps.create(:name => v_key, :content => v_value, :parent => help)
      end
    end

  end

end
