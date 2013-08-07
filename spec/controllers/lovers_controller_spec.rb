require 'spec_helper'

describe LoversController do
  render_views
  before (:each) do
      @request.env["AUTHORIZATION"] = "Token token=6HhJZ1hvsHjIox75dkndIg"
      @request.env["HTTP_ACCEPT"] = "application/json"
      @request.env["CONTENT_TYPE"] = "application/json"
  end
  describe "GET /users/:user_id/lovers" do
    it "gets all lovers from a user" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      pp "Logger: #{@request}"
      get  :index
      response.status.should be(200)
      expect(response.body).to include("\"user_id\":")

    end
  end

  describe "POST /users/:user_id/lovers" do
    it "creates a lover" do
      get  :create
      response.status.should be(200)
      expect(response.body).to include("\"user_id\":")
    end
  end

  describe "GET /users/:user_id/lovers" do
    it "gets a single user" do
      get  :show, :user_id => 1
      response.status.should be(200)
      expect(response.body).to include("\"user_id\":")

    end
  end

  describe "PUT /users/:user_id/lovers" do
    it "update a single user" do

      get  :update, :user_id => 1
      response.status.should be(200)
      expect(response.body).to include("\"user_id\":")

    end
  end

  describe "DELETE /users/:user_id/lovers" do
    it "remove a single user" do
      get  :destroy, :user_id => 1
      response.status.should be(200)
      expect(response.body).to include("removed successfully")

    end
  end

end
