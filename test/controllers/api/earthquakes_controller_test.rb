require "test_helper"

class Api::EarthquakesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_earthquakes_index_url
    assert_response :success
  end

  test "should get create_comment" do
    get api_earthquakes_create_comment_url
    assert_response :success
  end
end
