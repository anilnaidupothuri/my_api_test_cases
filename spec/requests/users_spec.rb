# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user1) { create(:user, name: 'user1', email: 'user1@gmail.com', password: '123456') }
  let!(:user2)  { create(:user, name: 'user2', email: 'user2@gmail.com', password: '123456') }
  describe 'GET /index' do
    context 'to get all users' do
      it 'should show all users' do
        get '/api/v1/users'
        expect(json['data'].count).to eq(2)
      end

      it 'returns status code 200' do
        get '/api/v1/users'
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /show' do
    it 'should show particular user' do
      get "/api/v1/users/#{user1.id}"
      
      expect(json['id']).to eq(user1.id)
      expect(json['name']).to eq(user1.name)
      
    end

    it "returns status code" do 
      get "/api/v1/users/#{user1.id}"
      expect(response).to have_http_status(200)
    end 
  end

  describe "POST /create" do 
    it "create user" do 
      post "/api/v1/users", params:{user:{name:"test", email:"test@gmail.com",
                            location:"kurunool", password:"123456"}}
      
      expect(json['data']['attributes']['name']).to eq("test")
      expect(json['data']['attributes']['email']).to eq("test@gmail.com")
      expect(json['data']['attributes']['location']).to eq("kurunool")
    end
  end 

  describe "PUT /update" do 
    it "user update" do 
      put "/api/v1/users/#{user1.id}", params:{user:{name:"anjali"}}, 
                                      headers:{Authorization: JsonWebToken.encode(user_id:user1.id)}
      
      expect(json['data']['attributes']["name"]).to eq("anjali")
      expect(json['data']['attributes']['name']).not_to eq("user1")
    end

    it "forbid user to update another user " do
       put "/api/v1/users/#{user1.id}", params:{user:{location:"hyd"}},
                                        headers:{Authorization:JsonWebToken.encode(user_id:user2.id)}
      expect(response).to have_http_status(403)
    end
     
    
  end

  describe "DELETE /destroy" do 
    it "should delete user" do 
      delete "/api/v1/users/#{user1.id}", headers:{Authorization: JsonWebToken.encode(user_id:user1.id)}
       
       expect(response).to have_http_status(204)
    end

    it "forbid user to delete another user" do 
      delete "/api/v1/users/#{user2.id}", headers:{Authorization: JsonWebToken.encode(user_id:user1.id)}

      expect(response).to have_http_status(403)
    end
  end 
end
