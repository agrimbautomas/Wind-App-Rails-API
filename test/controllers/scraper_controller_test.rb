require 'test_helper'

class wind-appControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get wind-app_index_url
    assert_response :success
  end

  test "should get scrape_site" do
    get wind-app_scrape_site_url
    assert_response :success
  end

end
