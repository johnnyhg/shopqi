# encoding: utf-8
class MembersController < InheritedResources::Base
  actions :show
  layout 'compact'
  prepend_before_filter :store_valid!, :authenticate_member!

  def show

  end
end
