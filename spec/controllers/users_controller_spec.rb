require 'spec_helper'
require 'pp'
require 'database_cleaner'

describe UsersController do
  render_views
  before (:all)do
      @admin= FactoryGirl.create(:user)
      pp @admin.remember_token
      @users= FactoryGirl.create_list(:user, 2)
  end
  before (:each) do
      request.env["HTTP_AUTHORIZATION"] = "Token token=#{@admin.remember_token}"
      request.env["HTTP_ACCEPT"] = "application/json"
      request.env["CONTENT_TYPE"] = "application/json"
  end
  after (:each) do

  end
  after (:all) do
    #@users.destroy
  end

  describe "GET /users" do
    it "gets all users" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      pp User.all
      pp @request
      get  :index
      response.status.should be(200)
      expect(response.body).to include("\"user_id\":")
      pp response.body

    end
  end

  describe "POST /users" do
    it "creates a user" do
      post  :create, FactoryGirl.attributes_for(:user)
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
      put  :update, :user_id => 1, :name => "Jose"
      response.status.should be(200)
      expect(response.body).to include("\"user_id\":")
      expect(response.body).to include("\"name\":\"Jose\"")

    end
  end

  describe "DELETE /users/:user_id" do
    it "remove a single user" do
      delete  :destroy, :user_id => 1
      response.status.should be(200)
      expect(response.body).to include("removed successfully")

    end
  end
end
