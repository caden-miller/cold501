json.extract! leaderboard_category, :id, :category_name, :min_points, :color, :created_at, :updated_at
json.url leaderboard_category_url(leaderboard_category, format: :json)
