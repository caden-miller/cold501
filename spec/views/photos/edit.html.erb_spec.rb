require 'rails_helper'

RSpec.describe "photos/edit", type: :view do
  let(:photo) {
    Photo.create!(
      link: "MyString",
      title: "MyString",
      description: "MyText",
      created_by: nil
    )
  }

  before(:each) do
    assign(:photo, photo)
  end

  it "renders the edit photo form" do
    render

    assert_select "form[action=?][method=?]", photo_path(photo), "post" do

      assert_select "input[name=?]", "photo[link]"

      assert_select "input[name=?]", "photo[title]"

      assert_select "textarea[name=?]", "photo[description]"

      assert_select "input[name=?]", "photo[created_by_id]"
    end
  end
end
