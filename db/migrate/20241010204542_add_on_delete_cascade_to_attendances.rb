# frozen_string_literal: true

# AddOnDeleteCascadeToAttendances
class AddOnDeleteCascadeToAttendances < ActiveRecord::Migration[7.0]
  def up
    remove_foreign_key :attendances, :events
    add_foreign_key :attendances, :events, on_delete: :cascade
  end

  def down
    remove_foreign_key :attendances, :events
    add_foreign_key :attendances, :events
  end
end
