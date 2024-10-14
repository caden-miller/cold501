# frozen_string_literal: true

class AddPasscodeToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :passcode, :string
  end
end
