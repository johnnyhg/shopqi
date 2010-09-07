# encoding: utf-8
module HotsHelper
  def partial_name
    resource.root? ? :item : :child
  end

  def position(direct)
    all = {
      :above => %w(前 上),
      :below => %w(后 下)
    }
    (resource.depth == 1) ? all[direct][1] : all[direct][0]
  end
end
