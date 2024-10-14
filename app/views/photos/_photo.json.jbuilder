# frozen_string_literal: true

json.extract! photo, :id, :link, :title, :description, :created_by_id, :created_at, :updated_at
json.url photo_url(photo, format: :json)
