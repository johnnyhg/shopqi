# encoding: utf-8
# 序列类
class Sequence
  include Mongoid::Document
  # 用于区别不同的序列(如不同网店)
  field :type
  field :day, :type => Date
  field :number, :type => Integer, :default => 1

  def self.get(type, day)
    sequence = self.where(:type => type, :day => day).first
    if sequence
      sequence.inc :number, 1
    else
      sequence = self.create(:type => type, :day => day)
    end
    sequence.number
  end

  # 返回格式: 2010102800001
  def self.next(type)
    day = Date.today
    "#{day.to_s(:serial)}#{self.get(type, day).to_s.rjust(5,'0')}"
  end

end
