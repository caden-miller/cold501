# frozen_string_literal: true

# app/controllers/attendances_controller.rb
class AttendancesController < ApplicationController
  before_action :set_event

  def create
    if valid_passcode?(params[:passcode])
      process_attendance
    else
      redirect_to @event, alert: 'Invalid passcode.'
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def valid_passcode?(entered_passcode)
    entered_passcode == @event.passcode
  end

  def process_attendance
    @attendance = Attendance.new(user: current_user, event: @event, present: true, checked_in_at: Time.current)

    if @attendance.save
      update_user_points
      redirect_to @event, notice: 'Successfully checked in.'
    else
      redirect_to @event, alert: @attendance.errors.full_messages.to_sentence
    end
  end

  def update_user_points
    current_user.update(points: current_user.points + 1)
  end
end
