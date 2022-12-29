# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let!(:user1) { create(:user, name: 'user1', email: 'user1@gmail.com', password: '123456') }
  let!(:product1) { create(:product, title: 'phone', quantity: 10, price: 14_000, published: true, user_id: user1.id) }
  let!(:order1) { create(:order, user_id: user1.id, total: 14_000) }
  # let!(:placement1) {create(:placement, product_id:product1.id, quantity:2, order_id:order1.id)}
  let(:order2) { create(:order) }

  describe 'GET /orders' do
    it 'return alln records' do
      # order2 = Order.create(product_ids_and_quantities:[{product_id:product1.id, quantity:2}])
      get '/api/v1/orders', headers: { Authorization: JsonWebToken.encode(user_id: order1.user_id) }
      expect(json['data'][0]['id']).to eq(order1.id.to_s)
    end

    it 'with out login forbiden' do
      get '/api/v1/orders'
      expect(response).to have_http_status(403)
    end
  end

  describe 'GET /show' do
    it 'return a user particluar order' do
      get "/api/v1/orders/#{order1.id}", headers: { Authorization: JsonWebToken.encode(user_id: order1.user_id) }

      expect(json['data']['id']).to eq(order1.id.to_s)
    end

    it 'with out login forbidden' do
      get '/api/v1/orders'
      expect(response).to have_http_status(403)
    end
  end

  describe 'POST /create' do
    it '' do
      post '/api/v1/orders', params: { order: { product_ids_and_quantities: [{ product_id: product1.id, quantity: 1 }] } },
                             headers: { Authorization: JsonWebToken.encode(user_id: user1.id) }

      expect(json).not_to be_empty
      expect(json['user_id']).to eq(user1.id)
    end

    it 'forbidden to create order with out login' do
      post '/api/v1/orders',
           params: { order: { product_ids_and_quantities: [{ product_id: product1.id, quantity: 3 }] } }

      expect(response).to have_http_status(403)
    end
  end
end
