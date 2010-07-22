require 'test_helper'

class ShopTest < ActiveSupport::TestCase

  fixtures :shops

  test 'name must be present' do
    shop = shops(:shop_one)
    assert shop.valid?

    shop.name = nil
    assert !shop.valid?

    shop.name = ''
    assert !shop.valid?
  end

  test 'name must be unique' do
    shop = Shop.new
    shop.name = shops(:shop_one).name
    assert !shop.valid?
  end
end
