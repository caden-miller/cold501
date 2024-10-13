# app/controllers/attendances_controller.rb
class AttendancesController < ApplicationController
  before_action :set_event

  def create
    passcode_entered = params[:event][:passcode]

    if passcode_entered == @event.passcode
      @attendance = Attendance.new(user: current_user, event: @event, present: true, checked_in_at: Time.current)
      
      if @attendance.save
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
