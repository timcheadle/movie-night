require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  def setup
    @vote = votes(:one)
  end

  test 'has a valid fixture' do
    assert @vote.valid?
  end

  should validate_presence_of(:person)
end
