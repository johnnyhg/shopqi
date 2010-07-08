class PagesController < InheritedResources::Base
  layout nil

  protected
  def resource
    @resource ||= end_of_association_chain.mbaobao
  end
end
