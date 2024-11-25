# frozen_string_literal: true

# Controller for managing events, including CRUD operations and attendance tracking.
class EventsController < ApplicationController
  helper EventsHelper

  before_action :set_event, only: %i[show edit update destroy archive unarchive]
  before_action :set_user, :role, :set_navbar_variables
  before_action :authenticate_admin!, only: %i[new create edit update destroy archive unarchive]
  before_action :authenticate_member!, only: %i[show]

  # Display all events
  def index
    start_date = parse_start_date(params[:start_date])
    end_date = start_date.end_of_month

    sort_column = params[:sort] || 'start_time'
    sort_direction = params[:direction] || 'asc'

    @events = Event.where(archived: false, start_time: start_date..end_date)
                   .order("#{sort_column} #{sort_direction}")
  end

  # Show a single event
  def show
    @attendances = Attendance.where(event: @event)
  end

  # Initialize a new event object
  def new
    @event = Event.new
  end

  # Edit an existing event
  def edit; end

  # Create a new event in the database
  def create
    Rails.logger.debug params[:event]
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Update an event in the database
  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Delete an event
  def destroy
    if @event.destroy
      redirect_to events_path, notice: 'Event was successfully deleted.'
    else
      redirect_to @event, alert: 'Error deleting event.'
    end
  end

  # Display all archived events
  def archived
    @archived_events = Event.where(archived: true)
  end

  # Archive an event
  def archive
    if @event.update(archived: true)
      redirect_to events_path, notice: 'Event was successfully archived.'
    else
      redirect_to @event, alert: 'Failed to archive event.'
    end
  end

  # Unarchive an event
  def unarchive
    if @event.update(archived: false)
      redirect_to archived_events_path, notice: 'Event was successfully unarchived and restored to the main list.'
    else
      redirect_to archived_events_path, alert: 'Failed to unarchive the event.'
    end
  end

  private

  # Parse the start date from parameters or default to the current month.
  def parse_start_date(start_date_param)
    if start_date_param.present?
      Time.zone.parse(start_date_param).beginning_of_month
    else
      Time.zone.today.beginning_of_month
    end
  end

  # Find event by ID for show, edit, update, and destroy actions
  def set_event
    @event = Event.find_by(id: params[:id])
  end

  # Strong parameters to prevent mass assignment issues
  def event_params
    params.require(:event).permit(:name, :passcode, :start_time, :end_time, :location, :description)
  end
end
