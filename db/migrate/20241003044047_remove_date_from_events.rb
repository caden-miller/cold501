# frozen_string_literal: true

# RemoveDateFromEvents
class RemoveDateFromEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :date, :datetime
  end
end
