class AddPriorityToIssues < ActiveRecord::Migration[5.0]
  def change
    add_column :issues, :priority, :integer, default: 0 
  end
end
