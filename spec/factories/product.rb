# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    title { 'laptop' }
    price { 65_000 }
    published { true }
    quantity { 19 }
  end
end
