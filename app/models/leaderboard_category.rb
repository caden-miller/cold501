# frozen_string_literal: true

# LeaderboardCategory
class LeaderboardCategory < ApplicationRecord
  validates :category_name, presence: true
  validates :min_points, presence: true
  validates :color, presence: true

  def self.category_for_user(points)
    where('min_points <= ?', points).order(min_points: :desc).first
  end

  def color_is_dark?
    r, g, b = color.scan(/../).map { |hex| hex.to_i(16) }
    brightness = (r * 299 + g * 587 + b * 114) / 1000
    brightness < 128
    
  end
end
