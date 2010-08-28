# encoding: utf-8
class ContainersController < InheritedResources::Base
  layout nil
  actions :new, :create, :edit, :update, :destroy
  respond_to :js, :only => [:create, :update, :destroy]

  create! do |success, failure|
    if resource.parent
      grids_sum = resource.parent.children.map(&:grids).sum
      resource.parent.children << Container.create(:grids => (resource.parent.grids - grids_sum)) if grids_sum < resource.parent.grids
      # 初始化位置
      resource.parent.children.init_list!
    end
  end

  protected
  def begin_of_association_chain
    current_user.store
  end
end
