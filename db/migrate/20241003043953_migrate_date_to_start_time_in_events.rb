# frozen_string_literal: true

class MigrateDateToStartTimeInEvents < ActiveRecord::Migration[7.0]
  def up
    Event.reset_column_information
    Event.where(start_time: nil).find_each do |event|
      event.update_column(:start_time, event.date)
    end
  end

  def down
    # Optional: Reverse the migration if needed
    Event.reset_column_information
    Event.where(date: nil).find_each do |event|
      event.update_column(:date, event.start_time)
    end
  end
end
