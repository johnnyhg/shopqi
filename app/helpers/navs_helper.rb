module NavsHelper
  def bar(collection, item)
    return '' if collection.nil?
    (item == collection.first) ? :no_bar : ''
  end
end
