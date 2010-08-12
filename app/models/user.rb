# encoding: utf-8
# 用户
class User
  include Mongoid::Document
  include SentientUser

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  referenced_in :store

  field :login

  # 校验
  validates_presence_of :login
  validates_uniqueness_of :login, :case_sensitive => false

  after_create :init_store

  def init_store
    # sentient_user
    self.store = if User.current
      User.current.store
    else
      self.make_current
      Store.create
    end
    self.save
  end

end
