require 'test_helper'

class GroupTopicsControllerTest < ActionController::TestCase
  setup do
    @group_topic = group_topics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_topics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_topic" do
    assert_difference('GroupTopic.count') do
      post :create, group_topic: { group_id: @group_topic.group_id, name: @group_topic.name, topic_id: @group_topic.topic_id }
    end

    assert_redirected_to group_topic_path(assigns(:group_topic))
  end

  test "should show group_topic" do
    get :show, id: @group_topic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_topic
    assert_response :success
  end

  test "should update group_topic" do
    put :update, id: @group_topic, group_topic: { group_id: @group_topic.group_id, name: @group_topic.name, topic_id: @group_topic.topic_id }
    assert_redirected_to group_topic_path(assigns(:group_topic))
  end

  test "should destroy group_topic" do
    assert_difference('GroupTopic.count', -1) do
      delete :destroy, id: @group_topic
    end

    assert_redirected_to group_topics_path
  end
end
