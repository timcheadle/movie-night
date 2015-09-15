class Vote < ActiveRecord::Base
  validates :person, presence: true
end
