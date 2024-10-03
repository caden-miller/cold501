# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_240_921_034_108) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'annoucements', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.integer 'created_by'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'attendances', force: :cascade do |t|
    t.bigint 'event_id', null: false
    t.bigint 'user_id', null: false
    t.boolean 'present'
    t.string 'passcode'
    t.datetime 'checked_in_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['event_id'], name: 'index_attendances_on_event_id'
    t.index ['user_id'], name: 'index_attendances_on_user_id'
  end

  create_table 'events', force: :cascade do |t|
    t.string 'name'
    t.datetime 'date'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'passcode'
  end

  create_table 'ideas', force: :cascade do |t|
    t.string 'title'
    t.string 'description'
    t.integer 'created_by'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'links', force: :cascade do |t|
    t.string 'title'
    t.string 'link'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'merchandises', force: :cascade do |t|
    t.string 'link'
    t.string 'title'
    t.string 'description'
    t.string 'image'
    t.integer 'stock'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'merches', force: :cascade do |t|
    t.string 'link'
    t.string 'title'
    t.string 'description'
    t.string 'image'
    t.integer 'stock'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'photos', force: :cascade do |t|
    t.text 'image_data'
    t.string 'title'
    t.text 'description'
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_photos_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', null: false
    t.string 'full_name'
    t.string 'uid'
    t.string 'avatar_url'
    t.string 'committee'
    t.integer 'points'
    t.integer 'dues'
    t.string 'role'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
  end

  add_foreign_key 'attendances', 'events'
  add_foreign_key 'attendances', 'users'
  add_foreign_key 'photos', 'users'
end
