# frozen_string_literal: true

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'shoud have a positive price ' do
    product = products(:one)
    product.price = -1
    assert_not product.valid?
  end

  test 'should filter produts by title' do
    assert_equal 1, Product.filter_by_title('first').count
  end

  test 'should filter by title and sort them' do
    assert_equal [products(:three)], Product.filter_by_title('first').sort
  end

  test 'should filter by price and sort them' do
    assert_equal [products(:three), products(:four)], Product.above_the_price(400).sort
  end
end
