class EventsController < ApplicationController
  def index
    @events = Event.all
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
      params.require(:event).permit(:location, :occurs_at)
    end
end
