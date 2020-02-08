require 'test_helper'

class AccessSchedulesControllerTest < ActionDispatch::IntegrationTest
  test "should get getSchedule" do
    get access_schedules_getSchedule_url
    assert_response :success
  end

  test "should get updateSchedule" do
    get access_schedules_updateSchedule_url
    assert_response :success
  end

  test "should get insertSchedule" do
    get access_schedules_insertSchedule_url
    assert_response :success
  end

  test "should get deleteSchedule" do
    get access_schedules_deleteSchedule_url
    assert_response :success
  end

end
