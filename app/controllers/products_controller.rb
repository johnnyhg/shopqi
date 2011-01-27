# encoding: utf-8
class ProductsController < InheritedResources::Base
  belongs_to :category, :optional => true
  actions :index, :new, :create, :edit, :update, :destroy, :show
  layout nil
  layout 'pages', :only => [:index, :show]
  respond_to :js, :only => [ :create, :update, :destroy, :add_to_car ]
  before_filter :set_object_id, :only => [:create, :update]
  prepend_before_filter :authenticate_user!, :except => [:index, :add_to_car, :show]
  prepend_before_filter :store_valid!, :only => :index

  def index
    @products = store.products
    @products = @products.any_in(:category_path => [BSON::ObjectId(params[:category_id])]) unless params[:category_id].blank?
  end

  create! do |success, failure|
    failure.js { render :action => "create.failure.js.haml"}
  end

  update! do |format|
    format.js { render :action => "create.js.haml"}
  end

  # 上传商品照片
  def upload
    @product = end_of_association_chain.find_or_create_by(:id => BSON::ObjectId(params[:id]))
    @photo = @product.photos.new(params[:photo])
    @product.photos << @photo
    @photo.save
    if @photo.errors.empty?
      render :action => "upload"
    else
      render :text => "$.jGrowl('#{@photo.errors[:file].join(',')}');"
    end
  end

  def add_to_car
    cookies['order'] = '' if cookies['order'].nil?
    # 格式: product_id|quantity;product_id|quantity
    stored_order = cookies['order'].split(';').map {|item| item.split('|')}
    order_hash = Hash[*stored_order.flatten]
    order_hash[params[:id]] = order_hash[params[:id]].to_i + params[:quantity].to_i
    cookies['order'] = order_hash.to_a.map{|item| item.join('|')}.join(';')
  end

  protected
  def begin_of_association_chain
    store
  end

  # 特殊处理:转换id，否则更新不了
  def set_object_id
    params[:product][:id] = BSON::ObjectId(params[:product][:id]) if params[:product][:id]
  end
end
