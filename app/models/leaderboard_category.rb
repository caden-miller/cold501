# frozen_string_literal: true

# LeaderboardCategory
class LeaderboardCategory < ApplicationRecord
  validates :category_name, presence: true
  validates :min_points, presence: true
  validates :color, presence: true
  after_commit :broadcast_leaderboard_update, on: [:create, :update, :destroy]

  def self.category_for_user(points)
    where('min_points <= ?', points).order(min_points: :desc).first
  end

  def color_is_dark?
    r, g, b = color.scan(/../).map { |hex| hex.to_i(16) }
    brightness = (r * 299 + g * 587 + b * 114) / 1000
    brightness < 128
  end

  private

  def broadcast_leaderboard_update
    users = User.all # Adjust this query as needed
    Turbo::StreamsChannel.broadcast_replace_to(
      "leaderboard",
      target: "leaderboard",
      partial: "leaderboard_categories/leaderboard",
      locals: { users: users }
    )
  end
end
