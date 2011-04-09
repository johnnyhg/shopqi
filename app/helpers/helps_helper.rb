module HelpsHelper
  def last(collection, item, class_name = :last)
    return '' if collection.nil?
    (item == collection.last) ? class_name : ''
  end

  # 指定url则使用url，否则直接显示help show page
  def url_or_special(help)
    help.url.blank? ? help_url(help) : help.url
  end
end
