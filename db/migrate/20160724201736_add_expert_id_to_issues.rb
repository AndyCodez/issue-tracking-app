class AddExpertIdToIssues < ActiveRecord::Migration[5.0]
  def change
    add_column :issues, :expert_id, :integer, default: 0
  end
end
