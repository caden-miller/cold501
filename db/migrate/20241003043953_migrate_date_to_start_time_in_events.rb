# frozen_string_literal: true

# MigrateDateToStartTimeInEvents
class MigrateDateToStartTimeInEvents < ActiveRecord::Migration[7.0]
  def up
    Event.reset_column_information
    Event.where(start_time: nil).find_each do |event|
      # Use `update` to respect validations, though this could cause issues if validations fail
      event.update(start_time: event.date)
    end
  end

  def down
    Event.reset_column_information
    Event.where(date: nil).find_each do |event|
      # Use `update` to reverse the migration
      event.update(date: event.start_time)
    end
  end
end
