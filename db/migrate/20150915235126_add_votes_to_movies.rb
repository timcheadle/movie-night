class AddVotesToMovies < ActiveRecord::Migration
  def change
    add_column :votes, :movie_id, :integer
  end
end
