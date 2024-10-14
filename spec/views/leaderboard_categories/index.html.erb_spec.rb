require 'rails_helper'

RSpec.describe "leaderboard_categories/index", type: :view do
  before(:each) do
    assign(:leaderboard_categories, [
      LeaderboardCategory.create!(
        category_name: "Category Name",
        min_points: 2,
        color: "Color"
      ),
      LeaderboardCategory.create!(
        category_name: "Category Name",
        min_points: 2,
        color: "Color"
      )
    ])
  end

  it "renders a list of leaderboard_categories" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Category Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Color".to_s), count: 2
  end
end
