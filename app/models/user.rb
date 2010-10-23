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

  after_create :init_store

  def init_store
    # sentient_user
    if User.current
      self.store = User.current.store
    else
      # store一定要与user关联后再保存，否则store关联的记录无法取到user.store
      store = Store.new
      self.store = store
      self.make_current
      store.save
    end
    self.save
  end

end
