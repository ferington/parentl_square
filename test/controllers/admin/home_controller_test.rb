require "test_helper"

class Admin::HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get intex" do
    get admin_home_intex_url
    assert_response :success
  end
end
