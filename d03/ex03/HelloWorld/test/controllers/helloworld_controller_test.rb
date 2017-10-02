require 'test_helper'

class HelloworldControllerTest < ActionController::TestCase
  test "should get helloworld" do
    get :helloworld
    assert_response :success
  end

end
