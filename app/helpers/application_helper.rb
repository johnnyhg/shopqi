module ApplicationHelper
  def id(model)
    "#{model.class.name.downcase}_#{model.id}"
  end

  def name(model)
    model.class.name.downcase
  end
end
