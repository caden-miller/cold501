# frozen_string_literal: true

# AddPasscodeToEvents
class AddPasscodeToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :passcode, :string
  end
end
