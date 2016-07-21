class AddCommentToIssues < ActiveRecord::Migration[5.0]
  def change
    add_column :issues, :comment, :text
  end
end
