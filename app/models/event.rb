class Event < ActiveRecord::Base
  has_many :movies, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :occurs_at, presence: true

  validates :location, presence: true,
                       uniqueness: {
                         scope: :occurs_at,
                         case_sensitive: false,
                         message: 'event already scheduled for that time'
                       }

  def winning_movie
    Vote.where(movie: movies).select(:movie_id).group(:movie_id).order('count(id) desc').first.movie
  end
end
