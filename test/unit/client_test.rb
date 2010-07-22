require 'test_helper'

class ClientTest < ActiveSupport::TestCase

  fixtures :clients

  test 'name must be present' do
    client = clients(:client_one)
    assert client.valid?

    client.name = nil
    assert !client.valid?

    client.name = ''
    assert !client.valid?
  end
  test 'address must be present' do
    client = clients(:client_one)
    assert client.valid?

    client.address = nil
    assert !client.valid?

    client.address = ''
    assert !client.valid?
  end
  
  test 'phone must be present' do
    client = clients(:client_one)
    assert client.valid?

    client.phone = nil
    assert !client.valid?

    client.phone = ''
    assert !client.valid?
  end
end
