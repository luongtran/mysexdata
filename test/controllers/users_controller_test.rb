require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { age: @user.age, email: @user.email, eye_color: @user.eye_color, facebook_id: @user.facebook_id, photo_id: @user.photo_id, hair_color: @user.hair_color, height: @user.height, integer: @user.integer, name: @user.name, password: @user.password, sex_gender: @user.sex_gender, sex_geo_id: @user.sex_geo_id, sex_interest: @user.sex_interest, startday: @user.startday }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { age: @user.age, email: @user.email, eye_color: @user.eye_color, facebook_id: @user.facebook_id, photo_id: @user.photo_id, hair_color: @user.hair_color, height: @user.height, integer: @user.integer, name: @user.name, password: @user.password, sex_gender: @user.sex_gender, sex_geo_id: @user.sex_geo_id, sex_interest: @user.sex_interest, startday: @user.startday }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
