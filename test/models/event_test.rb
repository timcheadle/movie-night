require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test 'has a valid fixture' do
    @event = events(:january)
    assert @event.valid?
  end

  should have_many(:movies)

  should validate_presence_of(:occurs_at)
  should validate_presence_of(:location)

  should validate_uniqueness_of(:location).
    scoped_to(:occurs_at).
    with_message('event already scheduled for that time').
    case_insensitive
end
