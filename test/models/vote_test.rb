require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  def setup
    @vote = votes(:alien_one)
  end

  test 'has a valid fixture' do
    assert @vote.valid?
  end

  should belong_to(:event)
  should belong_to(:movie)

  should validate_presence_of(:event)
  should validate_presence_of(:movie)
end
