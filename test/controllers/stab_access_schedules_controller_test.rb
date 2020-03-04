require 'test_helper'

class StabAccessSchedulesControllerTest < ActionDispatch::IntegrationTest
  test "should get getSchedule" do
    get stab_access_schedules_getSchedule_url
    assert_response :success
  end

end
