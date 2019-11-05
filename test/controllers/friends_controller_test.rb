require 'test_helper'

class FriendsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get friends_index_url
    assert_response :success
  end

  test "should get new" do
    get friends_new_url
    assert_response :success
  end

  test "should get create" do
    get friends_create_url
    assert_response :success
  end

  test "should get destroy" do
    get friends_destroy_url
    assert_response :success
  end

end
