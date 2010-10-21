class Member
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  referenced_in :store

  field :login

  # 校验
  validates_presence_of :login
  validates_uniqueness_of :login, :case_sensitive => false

end
