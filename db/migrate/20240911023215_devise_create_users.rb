# frozen_string_literal: true

# DeviseCreateUsers
class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email, null: false
      t.string :full_name
      t.string :uid
      t.string :avatar_url
      t.string :committee
      t.integer :points
      t.integer :dues
      t.string :role

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
