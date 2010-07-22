require 'test_helper'

class EstimateTest < ActiveSupport::TestCase

  test 'project must be present' do
    estimate = estimates(:estimate_one)
    assert estimate.valid?

    estimate.project_id = nil
    assert !estimate.valid?
  end

  test 'price must be present' do
    estimate = estimates(:estimate_one)
    assert estimate.valid?

    estimate.price = nil
    assert !estimate.valid?
  end

  test 'price must_be_numeric' do
    estimate = estimates(:estimate_one)
    assert estimate.valid?

    estimate.price = ''
    assert !estimate.valid?

    estimate.price = 'abc'
    assert !estimate.valid?

    estimate.price = 100
    assert estimate.valid?
  end
end
