require 'spec_helper'

token ="6HhJZ1hvsHjIox75dkndIg"

describe "Users" do
  describe "GET /users" do

    it "getting all users" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers

      get ("/users", nil, {'Content-Type' => 'application/json' ,'Authorization' => "Token token=#{token}"})
      response.status.should be(200)
      expect(response.body).to include("user_id:")

    end
  end
end
