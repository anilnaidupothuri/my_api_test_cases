class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name ,:email, :location 
  has_many :products

  
end
