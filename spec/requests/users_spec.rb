require 'spec_helper'

describe "Users Requests" do
  include AuthHelper
  before(:each) do
    http_login
  end

  describe "GET /users" do
    it "getting all users" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get  "/users.json"
      response.status.should be(200)
      expect(response.body).to include("user_id:")

    end
  end
end
