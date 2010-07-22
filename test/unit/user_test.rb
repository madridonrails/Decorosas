require 'test_helper'

class UserTest < ActiveSupport::TestCase
 
  fixtures :users

  test "validate login field" do
    user = User.new(:email => 'test@tests.com', :crypted_password => 'password', :password => 'password', :password_confirmation => 'password')
    user.crypted_password= 'crypted_password'
    assert !user.valid?
    
    user.login = users(:admin_user).login
    assert !user.valid?

    user.login = 'test_login'
    assert user.valid?
  end

  test "validate email field" do
    user = User.new(:login => 'test_login', :crypted_password => 'password', :password => 'password', :password_confirmation => 'password')
    user.crypted_password= 'crypted_password'
    assert !user.valid?

    user.email = 'wrong_email'
    assert !user.valid?

    user.email = 'wrong_email@'
    assert !user.valid?

    user.email = 'wrong_email@mysite'
    assert !user.valid?

    user.email = users(:admin_user).email
    assert !user.valid?

    user.email = 'valid_email@mysite.com'
    assert user.valid?

    user.email = 'another_valid_email@misitio.es'
    assert user.valid?
  end

  test "validate password field" do
    user = User.create(:email => 'test@example.com', :login => 'test')
    assert !user.valid?

    user = User.create(:email => 'test@example.com', :login => 'test', :crypted_password => 'password', :password => 'password', :password_confirmation => 'password')
    user.crypted_password= 'crypted_password'
    assert user.valid?
    
  end
end
