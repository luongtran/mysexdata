require 'spec_helper'

describe "photos/new" do
  before(:each) do
    assign(:photo, stub_model(Photo,
      :user_id => 1,
      :photo_id => 1,
      :photo_url => "MyString"
          ).as_new_record)
  end

  it "renders new photo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", photos_path, "post" do
      assert_select "input#photo_user_id[name=?]", "photo[user_id]"
      assert_select "input#photo_photo_id[name=?]", "photo[photo_id]"
      assert_select "input#photo_photo_url[name=?]", "photo[photo_url]"
    end
  end
end
