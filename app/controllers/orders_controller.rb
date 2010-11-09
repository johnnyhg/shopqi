# encoding: utf-8
class OrdersController < InheritedResources::Base
  prepend_before_filter :authenticate_member!, :except => [:car]
  actions :new, :create, :index, :show, :destroy
  respond_to :js, :only => [ :create ]
  layout 'members'

  # 提交订单
  def new
    init_cookie_orders
    super do |format| 
      format.html { render :layout => "compact" }
    end
  end

  def create
    init_cookie_orders
    params[:order].merge! :number => store.next_order_sequence, :quantity => @items_count, :price_sum => @price_count if params[:order]

    @order = end_of_association_chain.build(params[:order])
    @products.each do |product|
      quantity = @order_hash[product.id.to_s]
      price = product.price
      @order.items.build :product => product, :price => price, :quantity => quantity, :sum => quantity.to_i*price
    end

    create! do |success, failure|
      success.js { @path = pay_order_path(resource); render :template => "/shared/redirect" }
      failure.js { render :action => "create.failure.js.haml" }
    end
  end

  # 订单提交后的提示页面
  def pay
    flash[:success] = true
    render :action => "show"
  end

  # 会员取消订单
  #TODO: 先选择订单取消原因
  def cancel
    resource.cancel!
  end

  def car
    init_cookie_orders
    render :layout => "compact"
  end

  protected
  def begin_of_association_chain
    current_member
  end

  private
  def init_cookie_orders
    cookies['order'] = '' if cookies['order'].nil?
    order = cookies['order'].split(';').map{|item| item.split('|')}
    @products = order.map do |item|
      product_id = item[0]
      store.products.find(product_id)
    end
    @order_hash = Hash[*order.flatten]
    @items_count = @order_hash.values.map(&:to_i).sum
    @price_count = @products.map do |product|
      @order_hash[product.id.to_s].to_i * product.price
    end.sum
  end
end
