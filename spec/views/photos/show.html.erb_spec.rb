require 'spec_helper'

describe "photos/show" do
  before(:each) do
    @photo = assign(:photo, stub_model(Photo,
      :user_id => 1,
      :photo_id => 2,
      :photo_url => "Photo Url",
      :profile_photo => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Photo Url/)
    rendered.should match(/false/)
  end
end
