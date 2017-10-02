require 'test_helper'

class HelloworldControllerTest < ActionDispatch::IntegrationTest
  test "should get helloworld" do
    get helloworld_helloworld_url
    assert_response :success
  end

end
