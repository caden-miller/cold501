# frozen_string_literal: true

class AttendancesController < ApplicationController
  before_action :set_event

  def create
    passcode_entered = params[:passcode]

    if valid_passcode?(passcode_entered) && event_happening_today?
      attendance = @event.attendances.find_or_initialize_by(user: current_user)

      if attendance.persisted?
        redirect_to @event, alert: 'You have already checked in.'
      else
        attendance.assign_attributes(present: true, checked_in_at: Time.current)

        if attendance.save
          update_user_points
          redirect_to @event, notice: 'You have successfully checked in.'
        else
          redirect_to @event, alert: 'Unable to check in.'
        end
      end
    else
      redirect_to @event, alert: 'Invalid passcode or the event is not happening today.'
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def valid_passcode?(entered_passcode)
    entered_passcode == @event.passcode
  end

  def event_happening_today?
    @event.start_time.to_date <= Date.current && @event.end_time.to_date >= Date.current
  end

  def update_user_points
    current_user.update(points: current_user.points.to_i + 1)
  end
end
