# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :name, :password_digest, presence: true
  has_secure_password

  has_many :products, dependent: :destroy
end
