require 'rails_helper'

RSpec.describe "photos/new", type: :view do
  before(:each) do
    assign(:photo, Photo.new(
      link: "MyString",
      title: "MyString",
      description: "MyText",
      created_by: nil
    ))
  end

  it "renders new photo form" do
    render

    assert_select "form[action=?][method=?]", photos_path, "post" do

      assert_select "input[name=?]", "photo[link]"

      assert_select "input[name=?]", "photo[title]"

      assert_select "textarea[name=?]", "photo[description]"

      assert_select "input[name=?]", "photo[created_by_id]"
    end
  end
end
