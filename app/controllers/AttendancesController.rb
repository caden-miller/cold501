class AttendancesController < ApplicationController
  before_action :set_event

  def create
    @attendance = Attendance.find_or_initialize_by(event: @event, user: current_user)

    if @event.passcode == params[:attendance][:passcode] && @event.date.today?
      @attendance.update(present: true, checked_in_at: Time.current)
      redirect_to event_path(@event), notice: 'Successfully checked in.'
    else
      @attendance.update(present: false)
      redirect_to event_path(@event), alert: 'Invalid passcode or date.'
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end

