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

  test 'event has a winning movie' do
    assert_equal @event.winning_movie, movies(:alien)

    #event = Event.create(location: "foo", occurs_at: Time.now)
    #martian = event.movies.build(title: "The Martian", url: "martian.com")
    #porkys  = event.movies.build(title: "Porky's", url: "stayclassyjoe.com")

    #martian.vote("a")
    #martian.vote("b")
    #martian.vote("c")
    #porkys.vote("z")

    #assert_equal event.winning_movie, martian
  end
end
