class OrderSerializer
  include FastJsonapi::ObjectSerializer
  attributes :total
  belongs_to :user 
  has_many :products
end
