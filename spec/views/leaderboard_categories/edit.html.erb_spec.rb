require 'rails_helper'

RSpec.describe "leaderboard_categories/edit", type: :view do
  let(:leaderboard_category) {
    LeaderboardCategory.create!(
      category_name: "MyString",
      min_points: 1,
      color: "MyString"
    )
  }

  before(:each) do
    assign(:leaderboard_category, leaderboard_category)
  end

  it "renders the edit leaderboard_category form" do
    render

    assert_select "form[action=?][method=?]", leaderboard_category_path(leaderboard_category), "post" do

      assert_select "input[name=?]", "leaderboard_category[category_name]"

      assert_select "input[name=?]", "leaderboard_category[min_points]"

      assert_select "input[name=?]", "leaderboard_category[color]"
    end
  end
end
