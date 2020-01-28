require 'test_helper'

class StabControllerTest < ActionDispatch::IntegrationTest
  test "should get calender" do
    get stab_calender_url
    assert_response :success
  end

end
