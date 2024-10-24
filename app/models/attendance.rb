# frozen_string_literal: true

# Attendance
class Attendance < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :user_id, uniqueness: { scope: :event_id, message: 'has already checked into this event' }
end
