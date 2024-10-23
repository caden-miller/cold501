# frozen_string_literal: true

# AddArchivedToEvents
class AddArchivedToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :archived, :boolean, default: false, null: false
  end
end
