require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:alice)
  end

  test 'has a valid fixture' do
    assert @user.valid?
  end

  should validate_presence_of(:name)
  should validate_presence_of(:email)

  should have_many(:votes)
end
