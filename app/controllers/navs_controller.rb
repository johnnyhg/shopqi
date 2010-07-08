class NavsController < InheritedResources::Base
  layout nil
  actions :new, :create, :edit, :update, :destroy
  respond_to :js

  create! do |success, failure|
    resource.move(:above => Page.mbaobao.navs.find(params[:surround_resource_id]))
    Page.mbaobao.navs.init_list!
    failure.js { render :action => "create.failure.js.haml"}
  end

  edit! do |format|
    format.js { render :action => "new" }
  end

  update! do |success, failure|
    failure.js { render :action => "update.failure.js.haml"}
  end

  def sort
    params[:nav].each_with_index do |id, index|
      Page.mbaobao.navs.find(id).update_attributes :pos => index
    end
    render :nothing => true
  end

  protected
  def begin_of_association_chain
    Page.mbaobao
  end
end
