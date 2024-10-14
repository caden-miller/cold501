class CreateLeaderboardCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :leaderboard_categories do |t|
      t.string :category_name
      t.integer :min_points
      t.string :color

      t.timestamps
    end
  end
end
