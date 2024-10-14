require 'rails_helper'

RSpec.describe "leaderboard_categories/show", type: :view do
  before(:each) do
    assign(:leaderboard_category, LeaderboardCategory.create!(
      category_name: "Category Name",
      min_points: 2,
      color: "Color"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Category Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Color/)
  end
end
