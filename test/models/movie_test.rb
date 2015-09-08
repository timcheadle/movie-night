require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  test 'has a valid fixture' do
    @movie = movies(:lebowski)
    assert @movie.valid?
  end

  should validate_presence_of(:title)
  should validate_presence_of(:url)
end
