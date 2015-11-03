require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  def setup
    @movie = movies(:alien)
  end

  test 'has a valid fixture' do
    assert @movie.valid?
  end

  should belong_to(:event)
  should have_many(:votes)

  should validate_presence_of(:title)
  should validate_presence_of(:url)

  should validate_uniqueness_of(:title).
    scoped_to(:event_id).
    with_message('already suggested for that event').
    case_insensitive

  test 'should allow voting' do
    user = users(:alice)

    vote = @movie.vote(user)

    assert_equal @movie.votes.count, 3
    assert_equal user, vote.user
  end

  test 'should destroy related votes on delete' do
    assert_difference 'Vote.count', -2 do
      @movie.destroy
    end
  end
end
