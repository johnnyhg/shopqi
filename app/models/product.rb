class Product
  include Mongoid::Document
  include Formtastic::I18n::Naming

  referenced_in :category

  field :name
  field :price, :type => Float
  field :market_price, :type => Float

  validates_presence_of :name, :price
  validates_numericality_of :price
end
