require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get confirmation_instructions" do
    get static_pages_confirmation_instructions_url
    assert_response :success
  end
end
