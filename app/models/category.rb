class Category
  include Mongoid::Document
  include Mongoid::Acts::Tree

  field :name

  acts_as_tree
end
