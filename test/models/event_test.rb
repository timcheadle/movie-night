require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test 'has a valid fixture' do
    @event = events(:january)
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

  test 'event has a winning movie' do
    alien = movies(:alien)
    tron = movies(:tron)

    event = alien.event

    alien.vote('Alice')
    alien.vote('Bob')
    tron.vote('Cathy')

    assert_equal event.winning_movie, alien
  end
end
