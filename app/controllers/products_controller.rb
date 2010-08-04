class ProductsController < InheritedResources::Base
  actions :new, :create
  layout nil
  respond_to :js, :only => [ :create ]

  create! do |success, failure|
    failure.js { render :action => "create.failure.js.haml"}
  end

  # 提示消息
  def interpolation_options
     { :cn_resource_name => resource_class.model_name.human }
  end
end
