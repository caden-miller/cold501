# frozen_string_literal: true

json.array! @leaderboard_categories, partial: 'leaderboard_categories/leaderboard_category', as: :leaderboard_category
