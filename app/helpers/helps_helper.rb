module HelpsHelper
  def last(collection, item, class_name = :last)
    return '' if collection.nil?
    (item == collection.last) ? class_name : ''
  end
end
