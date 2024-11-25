# frozen_string_literal: true

# Add description column to events table
class AddDescriptionToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :description, :text
  end
end
