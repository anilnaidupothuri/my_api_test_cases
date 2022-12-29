# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :user
  validates :title, :user_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true

  has_many :placements
  has_many :orders, through: :placements

  scope :filter_by_title, ->(title) { where('lower(title) LIKE ?', "%#{title}%")}
  scope :above_the_price, ->(price) { where('price >= ?', price) }

  def self.search(params)
    products = Product.all
    products = Product.where(user_id: params[:user_id]) if params[:user_id]

    products = Product.filter_by_title(params[:title]) if params[:title]
    products = Product.above_the_price(params[:min_price]) if params[:min_price]
    
 
    products
  end
end
