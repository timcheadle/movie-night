class Vote < ActiveRecord::Base
  belongs_to :event
  belongs_to :movie

  validates :person, presence: true
  validates :event, presence: true
  validates :movie, presence: true
end
