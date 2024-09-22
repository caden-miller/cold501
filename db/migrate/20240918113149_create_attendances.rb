class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.references :event, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :present
      t.string :passcode
      t.datetime :checked_in_at

      t.timestamps
    end
  end
end
