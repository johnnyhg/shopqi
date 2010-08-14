# encoding: utf-8
class ProductsController < InheritedResources::Base
  actions :new, :create, :edit, :update, :destroy
  layout nil
  respond_to :js, :only => [ :create, :update, :destroy ]

  create! do |success, failure|
    failure.js { render :action => "create.failure.js.haml"}
  end

  update! do |format|
    format.js { render :nothing => true }
  end

  def upload
    @product = end_of_association_chain.find_or_create_by(:id => BSON::ObjectID(params[:id]))
    @photo = @product.photos.new(params[:photo])
    @product.photos << @photo
    @photo.save
    if @photo.errors.empty?
      render :action => "upload"
    else
      render :text => "$.jGrowl('#{@photo.errors[:file].join(',')}');"
    end
  end

  protected
  # 提示消息
  def interpolation_options
     { :cn_resource_name => resource_class.model_name.human }
  end

  def begin_of_association_chain
    current_user.store
  end
end
