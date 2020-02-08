require 'test_helper'

class AcsessDBsControllerTest < ActionDispatch::IntegrationTest
  test "should get getSchedule" do
    get acsess_d_bs_getSchedule_url
    assert_response :success
  end

  test "should get updateSchedule" do
    get acsess_d_bs_updateSchedule_url
    assert_response :success
  end

  test "should get insertSchedule" do
    get acsess_d_bs_insertSchedule_url
    assert_response :success
  end

  test "should get deleteSchedule" do
    get acsess_d_bs_deleteSchedule_url
    assert_response :success
  end

end
