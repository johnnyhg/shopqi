# encoding: utf-8
class CategoriesController < InheritedResources::Base
  #defaults :collection_name => :children
  # 使用optional参数，则调用parent前要先调用association_chain
  #belongs_to :category, :optional => true

  layout nil
  actions :index, :create, :update, :destroy
  respond_to :js, :only => [:create, :update, :destroy]
  respond_to :json, :only => [:index]

  create! do |format|
    # 初始化位置
    resource.parent.children.init_list!
    format.js { render :nothing => true }
  end

  update! do |format|
    unless params[:category][:name] # 改名
      # 移动
      neighbor = params[:category][:neighbor]
      if neighbor.blank?
        resource.move_to_bottom
      else
        resource.move_above(end_of_association_chain.find(neighbor)) 
      end
    end
    format.js { render :nothing => true }
  end

  destroy! do |format|
    format.js { render :nothing => true }
  end

  def index
    @result = params[:id].blank? ? end_of_association_chain.roots.first.children : end_of_association_chain.find(params[:id]).children
    render :json => get_attributes(@result).to_json
  end

  protected
  def get_attributes(list)
    list.map do |node|
      attribute = { :data => node.name, :attr => {:id =>  node.id.to_s } }
      # 叶子节点不需要state,children
      attribute.merge!(:state => "open", :children => get_attributes(node.children)) unless node.children.empty?
      attribute
    end
  end

  protected
  def begin_of_association_chain
    current_user.store
  end
end
