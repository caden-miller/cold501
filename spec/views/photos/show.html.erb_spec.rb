require 'rails_helper'

RSpec.describe "photos/show", type: :view do
  before(:each) do
    assign(:photo, Photo.create!(
      link: "Link",
      title: "Title",
      description: "MyText",
      created_by: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Link/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
