class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # Display all events
  def index
    @events = Event.all
  end

  # Show a single event
  def show
  end

  # Initialize a new event object
  def new
    @event = Event.new
  end

  # Edit an existing event
  def edit
  end

  # Create a new event in the database
  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  # Update an event in the database
  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end
  
  #set up delete
  def delete
    @event = Event.find(params[:id])
  end

  # Delete an event
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, notice: 'Event was successfully deleted.'
  end

  private

  # Find event by ID for show, edit, update, and destroy actions
  def set_event
    @event = Event.find_by(id: params[:id])
    if @event.nil?
      redirect_to root_path, alert: 'Event not found.'
    end
  end

  # Strong parameters to prevent mass assignment issues
  def event_params
    params.require(:event).permit(:name, :date)
  end
end

