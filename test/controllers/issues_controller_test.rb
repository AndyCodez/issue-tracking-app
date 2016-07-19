require 'test_helper'

class IssuesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_issue_path
    assert_response :success
  end

  # test "should get show" do
  #   get issue_path
  #   assert_response :success
  # end

  # test "should get index" do
  #   get issues_index_url
  #   assert_response :success
  # end

end
