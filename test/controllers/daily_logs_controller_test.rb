require "test_helper"

class DailyLogsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get daily_logs_index_url
    assert_response :success
  end
end
