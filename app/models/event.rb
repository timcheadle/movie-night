class Event < ActiveRecord::Base
  validates :location, presence: true

  validates :occurs_at, presence: true,
                        uniqueness: { scope: :location, message: 'already scheduled for that location' }
end
