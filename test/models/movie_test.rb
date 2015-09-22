require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  def setup
    @movie = movies(:lebowski)
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
end
