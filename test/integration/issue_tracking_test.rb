require 'test_helper'

class IssueTrackingTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:archer)
    @admin = users(:andy)
    @issue = issues(:shida)
    ActionMailer::Base.deliveries.clear
  end

  test "notify user when comment is made on his issue" do
    assert @admin.admin? 
    log_in_as @admin
    get issues_path
    get show_issue_path(id: 1)
    assert_select "h2", "Kichwa" 
    post comments_path(id: @issue.id, user_id: @issue.user_id),
      params: {
      comment: {
        content: "This is what we expect to be the admin's comment being made on an issue raised by the user"
      }
    }
      follow_redirect!
      assert_not flash.empty?
      assert_equal 1, ActionMailer::Base.deliveries.size
  end
end
