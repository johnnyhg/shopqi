# encoding: utf-8
class Member
  include Mongoid::Document
  include SentientUser
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  referenced_in :store
  references_many :orders, :dependent => :destroy
  embeds_many :addresses

  field :login

  #@see: https://github.com/bokmann/sentient_user/blob/master/lib/sentient_user.rb
  def self.current
    Thread.current[:member]
  end

  def self.current=(o)
    Thread.current[:member] = o
  end

  def make_current
    Thread.current[:member] = self
  end
end
