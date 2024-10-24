# frozen_string_literal: true

# DeviseCreateUsers
class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_users_table
    add_users_indexes
  end

  private

  def create_users_table
    create_table :users do |table|
      add_user_profile_columns(table)
      add_user_role_and_points_columns(table)

      table.timestamps null: false
    end
  end

  def add_user_profile_columns(table)
    table.string :email, null: false
    table.string :full_name
    table.string :uid
    table.string :avatar_url
    table.string :committee
  end

  def add_user_role_and_points_columns(table)
    table.integer :points
    table.integer :dues
    table.string :role
  end

  def add_users_indexes
    add_index :users, :email, unique: true
  end
end
