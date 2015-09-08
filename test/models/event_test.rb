require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test 'has a valid fixture' do
    @event = events(:one)
    assert @event.valid?
  end

  should validate_presence_of(:occurs_at)
  should validate_presence_of(:location)

  should validate_uniqueness_of(:occurs_at)
    .scoped_to(:location)
    .with_message('already scheduled for that location')
end
