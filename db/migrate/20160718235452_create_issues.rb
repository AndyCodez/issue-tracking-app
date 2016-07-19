class CreateIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :issues do |t|
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :issues, [:user_id, :created_at]
  end
end
