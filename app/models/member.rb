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
end
