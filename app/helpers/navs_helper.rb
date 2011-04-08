module NavsHelper
  #TODO: change to first
  def bar(collection, item, class_name = :first)
    return '' if collection.nil?
    (item == collection.first) ? class_name : ''
  end
end
