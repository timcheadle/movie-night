class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @query = params[:search]

    if @query.present?
      @events = Event.where('location ILIKE ?', "%#{@query}%")

      # Also search by movie title
      movies = Movie.where('title ILIKE ?', "%#{@query}%")
      @events += movies.map(&:event)
      @events.uniq!
    else
      @events = Event.all
    end
  end

  def show
    @event = Event.find(params[:id])
    @movie = Movie.new
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event, notice: 'Event created successfully'
    else
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event, notice: 'Event created successfully'
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])

    @event.destroy
    redirect_to events_url, notice: 'Event deleted successfully'
  end

  private

    def event_params
      params.require(:event).permit(:location, :occurs_at, :search)
    end
end
