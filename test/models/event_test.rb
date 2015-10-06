require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @event = events(:january)
  end

  test 'has a valid fixture' do
    assert @event.valid?
  end

  should have_many(:movies)
  should have_many(:votes)

  should validate_presence_of(:occurs_at)
  should validate_presence_of(:location)

  should validate_uniqueness_of(:location).
    scoped_to(:occurs_at).
    with_message('event already scheduled for that time').
    case_insensitive

  test 'should destroy related movies on delete' do
    assert_difference 'Movie.count', -3 do
      @event.destroy
    end
  end

  test 'should destroy related votes on delete' do
    assert_difference 'Vote.count', -3 do
      @event.destroy
    end
  end

    assert_equal event.winning_movie, alien
  end
end
