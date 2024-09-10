json.extract! merch, :id, :link, :title, :description, :image, :stock, :created_at, :updated_at
json.url merch_url(merch, format: :json)
