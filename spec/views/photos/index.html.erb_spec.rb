require 'rails_helper'

RSpec.describe "photos/index", type: :view do
  before(:each) do
    assign(:photos, [
      Photo.create!(
        link: "Link",
        title: "Title",
        description: "MyText",
        created_by: nil
      ),
      Photo.create!(
        link: "Link",
        title: "Title",
        description: "MyText",
        created_by: nil
      )
    ])
  end

  it "renders a list of photos" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Link".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
