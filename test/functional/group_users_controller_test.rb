require 'test_helper'

class CommunityUsersControllerTest < ActionController::TestCase
  setup do
    @community_user = community_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:community_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create community_user" do
    assert_difference('CommunityUser.count') do
      post :create, community_user: { community_id: @community_user.community_id, status: @community_user.status, user_id: @community_user.user_id }
    end

    assert_redirected_to community_user_path(assigns(:community_user))
  end

  test "should show community_user" do
    get :show, id: @community_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @community_user
    assert_response :success
  end

  test "should update community_user" do
    put :update, id: @community_user, community_user: { community_id: @community_user.community_id, status: @community_user.status, user_id: @community_user.user_id }
    assert_redirected_to community_user_path(assigns(:community_user))
  end

  test "should destroy community_user" do
    assert_difference('CommunityUser.count', -1) do
      delete :destroy, id: @community_user
    end

    assert_redirected_to community_users_path
  end
end
