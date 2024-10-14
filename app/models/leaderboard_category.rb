class LeaderboardCategory < ApplicationRecord
    def self.category_for_user(points)
        where('min_points <= ?', points).order(min_points: :desc).first
    end
end
