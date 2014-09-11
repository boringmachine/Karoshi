require 'test_helper'

class CommunityTopicsControllerTest < ActionController::TestCase
  setup do
    @community_topic = community_topics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:community_topics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create community_topic" do
    assert_difference('CommunityTopic.count') do
      post :create, community_topic: { community_id: @community_topic.community_id, status: @community_topic.status, topic_id: @community_topic.topic_id }
    end

    assert_redirected_to community_topic_path(assigns(:community_topic))
  end

  test "should show community_topic" do
    get :show, id: @community_topic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @community_topic
    assert_response :success
  end

  test "should update community_topic" do
    put :update, id: @community_topic, community_topic: { community_id: @community_topic.community_id, status: @community_topic.status, topic_id: @community_topic.topic_id }
    assert_redirected_to community_topic_path(assigns(:community_topic))
  end

  test "should destroy community_topic" do
    assert_difference('CommunityTopic.count', -1) do
      delete :destroy, id: @community_topic
    end

    assert_redirected_to community_topics_path
  end
end
