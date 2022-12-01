class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name ,:email, :location , :password
  has_many :products
end
