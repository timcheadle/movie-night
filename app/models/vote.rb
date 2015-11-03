class Vote < ActiveRecord::Base
  belongs_to :event
  belongs_to :movie
  belongs_to :user

  validates :event, presence: true
  validates :movie, presence: true
  validates :user, presence: true
end
