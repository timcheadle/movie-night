class Vote < ActiveRecord::Base
  belongs_to :event
  belongs_to :movie

  validates :person, presence: true
end
