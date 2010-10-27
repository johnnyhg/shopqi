# encoding: utf-8
class OrdersController < InheritedResources::Base
  prepend_before_filter :authenticate_member!, :except => [:car, :create]
  actions :index, :show, :destroy
  layout 'pages'

  def create
    @path = orders_path
    if current_member
      end_of_association_chain.create :number => :aa, :price_count => 10.0, :state => 3
    end
  end

  def car
    order = cookie_orders
    @products = order.map do |item|
      product_id = item[0]
      store.products.find(product_id)
    end
    @order_hash = Hash[*order.flatten]
    @items_count = @order_hash.values.map(&:to_i).sum
    @price_count = @products.map do |product|
      @order_hash[product.id.to_s].to_i * product.price
    end.sum
    render :layout => "compact"
  end

  protected
  def begin_of_association_chain
    current_member
  end

  def cookie_orders
    cookies['order'] = '' if cookies['order'].nil?
    cookies['order'].split(';').map{|item| item.split('|')}
  end
end
