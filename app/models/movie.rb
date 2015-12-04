class Movie < ActiveRecord::Base
  belongs_to :event
  has_many :votes, dependent: :destroy

  validates :event, presence: true
  validates :url, presence: true

  validates :title, presence: true,
                    uniqueness: {
                      scope: :event_id,
                      case_sensitive: false,
                      message: 'already suggested for that event'
                    }

  def vote(user)
    Vote.create(movie: self, event: event, user: user)
  end

  after_create :update_poster_path

  def update_poster_path
    found_movies = Tmdb::Movie.find(self.title)
    if found_movies.any?
      self.poster_url = found_movies.first.poster_path
      save
    end
  end

  def get_poster_url(width=500)
    config = Tmdb::Configuration.new
    "#{config.base_url}w#{width}#{self.poster_url}"
  end
end
