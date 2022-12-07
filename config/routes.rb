# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'tokens/create'
    end
  end
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users
      resources :products
      resources :orders
      resources :tokens, only: [:create]
    end
  end
end
