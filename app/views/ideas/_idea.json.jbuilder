# frozen_string_literal: true

json.extract! idea, :id, :title, :description, :created_by, :created_at, :created_at, :updated_at
json.url idea_url(idea, format: :json)
