require 'test_helper'

class Admin::PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get admin_pages_main_url
    assert_response :success
  end

end
