module ApplicationHelper
  delegate :template, :to => :store

  def store
    Store.where(:subdomain => request.subdomain).first
  end

  def editinplace(model, attr, options = {})
    options[:class] = [options[:class], :editinplace].compact
    # 用于ajax提交时指定更新的字段名称
    options['data-name'] = attr
    content_tag(:span, model.send(attr), options)
  end

  def id(model)
    "#{name(model)}_#{model.id}"
  end

  def name(model)
    model.class.name.downcase
  end

  # 实体的校验要越少越好，则名称不输入时显示[未命名]
  def s(label)
    label.blank? ? I18n.t('helper.label.blank') : label
  end
end
