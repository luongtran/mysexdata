require 'spec_helper'
require 'pp'

describe UsersController do
  render_views
  describe "GET /users" do
    it "gets all users" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      @request.env["AUTHORIZATION"] = "Token token=6HhJZ1hvsHjIox75dkndIg"
      @request.env["HTTP_ACCEPT"] = "application/json"
      @request.env["CONTENT_TYPE"] = "application/json"
      pp "Logger: #{@request}"
      get  :index
      response.status.should be(200)
      expect(response.body).to include("\"user_id\":")

    end
  end
end
