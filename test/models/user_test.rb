# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'user with name nil should be invalid' do
    user = User.new(name: '', email: 'email@gmail.com', password_digest: 'test', location: 'hyd')
    assert_not user.valid?
  end
  test 'users with taken email should be invalid' do
    other_user = users(:one)
    user = User.new(name: 'three', email: other_user.email, password_digest: 'test', location: 'hyd')
    assert_not user.valid?
  end
end
