require 'test_helper'

class CalendarsControllerTest < ActionDispatch::IntegrationTest
  test "should get calendar" do
    get calendars_calendar_url
    assert_response :success
  end

  test "should get inputSchedule" do
    get calendars_inputSchedule_url
    assert_response :success
  end

  test "should get manipulateSchedule" do
    get calendars_manipulateSchedule_url
    assert_response :success
  end

  test "should get deleteConfirm" do
    get calendars_deleteConfirm_url
    assert_response :success
  end

end
