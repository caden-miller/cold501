require 'rails_helper'

RSpec.describe "leaderboard_categories/new", type: :view do
  before(:each) do
    assign(:leaderboard_category, LeaderboardCategory.new(
      category_name: "MyString",
      min_points: 1,
      color: "MyString"
    ))
  end

  it "renders new leaderboard_category form" do
    render

    assert_select "form[action=?][method=?]", leaderboard_categories_path, "post" do

      assert_select "input[name=?]", "leaderboard_category[category_name]"

      assert_select "input[name=?]", "leaderboard_category[min_points]"

      assert_select "input[name=?]", "leaderboard_category[color]"
    end
  end
end
