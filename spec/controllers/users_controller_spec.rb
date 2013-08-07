require 'spec_helper'
require 'pp'

describe UsersController do
  render_views
  before (:each) do
      @request.env["AUTHORIZATION"] = "Token token=6HhJZ1hvsHjIox75dkndIg"
      @request.env["HTTP_ACCEPT"] = "application/json"
      @request.env["CONTENT_TYPE"] = "application/json"
  end
  describe "GET /users" do
    it "gets all users" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      pp "Logger: #{@request}"
      get  :index
      response.status.should be(200)
      expect(response.body).to include("\"user_id\":")

    end
  end

  describe "POST /users" do
    it "creates a user" do
      get  :create
      response.status.should be(200)
      expect(response.body).to include("\"user_id\":")

    end
  end

  describe "GET /users/:user_id" do
    it "gets a single user" do
      get  :show, :user_id => 1
      response.status.should be(200)
      expect(response.body).to include("\"user_id\":")

    end
  end

  describe "PUT /users/:user_id" do
    it "update a single user" do

      get  :update, :user_id => 1
      response.status.should be(200)
      expect(response.body).to include("\"user_id\":")

    end
  end

  describe "DELETE /users/:user_id" do
    it "remove a single user" do
      get  :destroy, :user_id => 1
      response.status.should be(200)
      expect(response.body).to include("removed successfully")

    end
  end
end
