module ApplicationHelper
  def id(model)
    "#{model.class.name.downcase}_#{model.id}"
  end
end
