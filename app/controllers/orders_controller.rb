# encoding: utf-8
class OrdersController < ApplicationController
  def index
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
