namespace :movies do
  desc 'Update movie poster URLs'
  task update_posters: :environment do
    Movie.all.each { |m| m.update_poster_path }
  end
end
