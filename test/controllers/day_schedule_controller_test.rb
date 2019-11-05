require 'test_helper'

class DayScheduleControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get day_schedule_show_url
    assert_response :success
  end

  test "should get new" do
    get day_schedule_new_url
    assert_response :success
  end

  test "should get create" do
    get day_schedule_create_url
    assert_response :success
  end

end
