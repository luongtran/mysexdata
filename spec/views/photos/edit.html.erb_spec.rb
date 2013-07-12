require 'spec_helper'

describe "photos/edit" do
  before(:each) do
    @photo = assign(:photo, stub_model(Photo,
      :user_id => 1,
      :photo_id => 1,
      :photo_url => "MyString",
    ))
  end

  it "renders the edit photo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", photo_path(@photo), "post" do
      assert_select "input#photo_user_id[name=?]", "photo[user_id]"
      assert_select "input#photo_photo_id[name=?]", "photo[photo_id]"
      assert_select "input#photo_photo_url[name=?]", "photo[photo_url]"
    end
  end
end
