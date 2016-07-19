require 'test_helper'

class IssueTest < ActiveSupport::TestCase

  def setup
    @user = users(:makatunga)
    @issue = @user.issues.build( description: "Lorem ipsum dolor sit amet, consectetur adipiscin.", user_id: @user.id)
  end

  test "should be valid" do
    assert @issue.valid?
  end

  test "user id should be present" do
    @issue.user_id = nil
    assert_not @issue.valid?
  end

  test "description should be present" do
    @issue.description = " "
    assert_not @issue.valid?
  end

  test "description should be at least 50 characters" do
    @issue.description = "a"*49
    assert_not @issue.valid?
  end
end
