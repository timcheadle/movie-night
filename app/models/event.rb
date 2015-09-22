class Event < ActiveRecord::Base
  has_many :movies
  has_many :votes

  validates :occurs_at, presence: true

  validates :location, presence: true,
                       uniqueness: {
                         scope: :occurs_at,
                         case_sensitive: false,
                         message: 'event already scheduled for that time'
                       }
end
