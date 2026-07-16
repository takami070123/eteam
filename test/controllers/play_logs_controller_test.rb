require "test_helper"

class PlayLogsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get play_logs_index_url
    assert_response :success
  end
end
