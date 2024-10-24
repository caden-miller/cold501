# frozen_string_literal: true

# AddEndTimeToEvents
class AddEndTimeToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :end_time, :datetime
  end
end
