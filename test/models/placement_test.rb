require 'test_helper'

class PlacementTest < ActiveSupport::TestCase
  setup do 
    @placement = placements(:one)
  end 

  test 'decrease the product quantity by the placement qunatity' do 
    product = @placement.product

    assert_difference('product.quantity', -@placement.qunatity) do 
      @placement.decrement_product_qunatity!
    end 
  end

end
