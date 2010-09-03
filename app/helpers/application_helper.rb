module ApplicationHelper
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
