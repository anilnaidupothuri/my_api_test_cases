FactoryBot.define do
  factory :order do
    user { User.first }
    total { 200 }
  end
end
