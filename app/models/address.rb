class Address
  include Mongoid::Document
  field :name, :type => String
  field :province, :type => String
  field :city, :type => String
  field :district, :type => String
  field :detail, :type => String
  field :zipcode, :type => String
  field :mobile, :type => String
  field :phone, :type => String
end
