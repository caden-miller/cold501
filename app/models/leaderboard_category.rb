# frozen_string_literal: true

class LeaderboardCategory < ApplicationRecord
  validates :category_name, presence: true
  validates :min_points, presence: true
  validates :color, presence: true

  def self.category_for_user(points)
    where('min_points <= ?', points).order(min_points: :desc).first
  end
end
