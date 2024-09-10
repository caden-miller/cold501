json.extract! user, :id, :name, :image, :email, :password, :role, :committee, :points, :uid, :token, :provider, :created_at, :updated_at
json.url user_url(user, format: :json)
