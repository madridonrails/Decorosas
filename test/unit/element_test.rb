require 'test_helper'

class ElementTest < ActiveSupport::TestCase

  fixtures :elements

  test 'description must be present' do
    element = elements(:element_one)
    assert element.valid?

    element.description = nil
    assert !element.valid?

    element.description = ''
    assert !element.valid?
  end

  test 'cost_price must be present' do
    element = elements(:element_one)
    assert element.valid?

    element.cost_price = nil
    assert !element.valid?

    element.cost_price = ''
    assert !element.valid?
  end

  test 'cost_price must be float' do
    element = elements(:element_one)
    assert element.valid?

    element.cost_price = 'abc'
    assert !element.valid?

    element.cost_price = 10
    assert element.valid?
  end
  
  test 'units must be present' do
    element = elements(:element_one)
    assert element.valid?

    element.units = nil
    assert !element.valid?

    element.units = ''
    assert !element.valid?
  end

  test 'units must be an integer' do
    element = elements(:element_one)
    assert element.valid?

    element.units = 'abc'
    assert !element.valid?

    element.units = 10.7
    assert !element.valid?
  end

  test 'estimate_id must be present' do
    element = elements(:element_one)
    assert element.valid?

    element.estimate_id = nil
    assert !element.valid?

    element.estimate_id = ''
    assert !element.valid?
  end

  test 'assembly_price must be present' do
    element = elements(:element_one)
    assert element.valid?

    element.assembly_price = nil
    assert !element.valid?

    element.assembly_price = ''
    assert !element.valid?
  end

  test 'assembly_price must be float' do
    element = elements(:element_one)
    assert element.valid?

    element.assembly_price = 'abc'
    assert !element.valid?

    element.assembly_price = 10
    assert element.valid?
  end
end
