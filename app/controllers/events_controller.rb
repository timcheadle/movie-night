class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def edit
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
  end

  def destroy
  end

  private

    def event_params
      params.require(:event).permit(:location, :occurs_at)
    end
end
