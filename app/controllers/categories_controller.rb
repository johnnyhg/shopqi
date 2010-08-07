# encoding: utf-8
class CategoriesController < InheritedResources::Base
  layout nil
  actions :index, :new, :create, :edit, :update, :destroy
  respond_to :js, :only => [:create, :update, :destroy]
  respond_to :json, :only => [:index]

  create! do |format|
    # 初始化位置
    parent = Category.find(params[:category][:parent_id])
    parent.children.init_list!
    format.js { render :nothing => true }
  end

  update! do |format|
    unless params[:category][:name] # 改名
      # 移动
      neighbor = params[:category][:neighbor]
      if neighbor.blank?
        resource.move_to_bottom
      else
        resource.move_above(Category.find(neighbor)) 
      end
    end
    format.js { render :nothing => true }
  end

  destroy! do |format|
    format.js { render :nothing => true }
  end

  def index
    @result = params[:id].blank? ? Category.roots.first.children : Category.find(params[:id]).children
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
end
