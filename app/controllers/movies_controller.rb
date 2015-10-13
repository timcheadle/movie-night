class MoviesController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @movie = @event.movies.build(movie_params)

    if @movie.save
      redirect_to @event, notice: 'Movie created successfully'
    else
      render 'events/show'
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @movie = Movie.find(params[:id])

    @movie.destroy
    redirect_to @event, notice: 'Movie deleted successfully'
  end

  private

    def movie_params
      params.require(:movie).permit(:event_id, :title, :url)
    end
end
