json.extract! merchandise, :id, :link, :title, :description, :image, :stock, :created_at, :updated_at
json.url merchandise_url(merchandise, format: :json)
