# app/controllers/attendances_controller.rb
class AttendancesController < ApplicationController
  before_action :set_event

  def create
    passcode_entered = params[:passcode] # Adjusted to fetch passcode correctly

    if passcode_entered == @event.passcode
      @attendance = Attendance.new(user: current_user, event: @event, present: true, checked_in_at: Time.current)

      if @attendance.save
        current_user.update(points: current_user.points + 1) # Update user points
        redirect_to @event, notice: 'Successfully checked in.'
      else
        redirect_to @event, alert: @attendance.errors.full_messages.to_sentence
      end
    else
      redirect_to @event, alert: 'Invalid passcode.'
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
