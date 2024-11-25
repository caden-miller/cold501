# frozen_string_literal: true

# Change dues column type from integer to text in users table
class ChangeDuesColumnTypeInUsers < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :dues, :text
  end

  def down
    change_column :users, :dues, :integer
  end
end
