# frozen_string_literal: true

# AddUniqueIndexToAttendances
class AddUniqueIndexToAttendances < ActiveRecord::Migration[7.0]
  def change
    add_index :attendances, %i[user_id event_id], unique: true
  end
end
