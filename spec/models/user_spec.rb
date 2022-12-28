require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email)}
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:password_digest)}

  it {should validate_uniqueness_of(:email)}
  it {should have_secure_password}

  it {should have_many(:products).dependent(:destroy)}
  it {should have_many(:orders).dependent(:destroy)}
  #it {should have_one_atteched(:image)}
end
