class CreateProjectComments < ActiveRecord::Migration
  def change
    create_table :project_comments do |t|
      t.integer :project_id
      t.text :comment
      t.integer :user_id
      t.timestamps
    end
  end
end
