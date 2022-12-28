require 'rails_helper'

RSpec.describe "Products", type: :request do
  let!(:user1) {create(:user, name:"naruto", email:"naruto@gmail.com", location:"leaf village",password:"datteboy")}
  let!(:user2) {create(:user, name:"sasuke", email:"sasuke@gmail.com", location:"leaf village", password:"annoying")}
  let!(:product1) {create(:product, title:"firdge", price:30000, published:true, user_id:user1.id)}
  let!(:product2) {create(:product, title:"cooler", price:1500, published:true, user_id:user1.id)}


  describe "GET /products" do
    it "return all products " do
      get "/api/v1/products"
      expect(json['data'].count).to eq(2)
      expect(json).not_to be_empty
      # expect(json['date'][0]['id']).to eq(product1.id)
      # expect(json['data'][1]['id']).to eq(product2.id)

    end

    # it "when filter is applied for name" do 

    # end
    it "return status code 200" do 
      get "/api/v1/products"
          expect(response).to have_http_status(200)
    end
  end

  describe "GET /show" do 
    it "show particular product only" do 
     get "/api/v1/products/#{product1.id}"
     
    expect(json['data']['id']).to eq(product1.id.to_s)
    expect(json['data']['attributes']['title']).to eq(product1.title)
    expect(json['data']['attributes']['price']).to eq(product1.price)
    expect(json['data']['attributes']['user_id']).to eq(product1.user_id)

  end
  end 

  describe "POST /create" do 
    it "create products" do
       post "/api/v1/products", params:{product:{title:"laptop", price:60000, published:true}},
                               headers:{Authorization:JsonWebToken.encode(user_id:user1.id)}
       
       expect(json['data']['attributes']['title']).to eq("laptop")
       expect(json['data']['attributes']['price']).to eq(60000) 
       expect(json['data']['attributes']['user_id']).to eq(user1.id)
    end
  end 

  describe "PUT /update" do 
    it "update products" do 
      put "/api/v1/products/#{product2.id}", params:{product:{price:2000}},
                                             headers:{Authorization: JsonWebToken.encode(user_id:user1.id)}
       
      expect(json['data']['attributes']['price']).to eq(2000)
      expect(json['data']['attributes']['price']).not_to eq(1500)
    end 

    it "forbid to update product for another user" do 
      put "api/v1/products/#{product2.id}", params:{products:{price:2000}},
                                            headers:{Authorization: JsonWebToken.encode(user_id:user2.id)}

      expect(response).to have_http_status(403)
    end
  end 

  describe "DELETE /destroy" do 
    it "to delete product" do 
      delete "/api/v1/products/#{product2.id}", headers:{Authorization:JsonWebToken.encode(user_id:user1.id)}
      expect(response).to have_http_status(204)
    end
    
  end 
end
