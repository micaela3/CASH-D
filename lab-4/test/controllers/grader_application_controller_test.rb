require 'test_helper'

class GraderApplicationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get grader_application_index_url
    assert_response :success
  end

  test "should get edit" do
    get grader_application_edit_url
    assert_response :success
  end

end
