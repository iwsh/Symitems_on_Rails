require 'test_helper'

class StabAuthenticationsControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get stab_authentications_login_url
    assert_response :success
  end

  test "should get checkUser" do
    get stab_authentications_checkUser_url
    assert_response :success
  end

  test "should get logout" do
    get stab_authentications_logout_url
    assert_response :success
  end

end
