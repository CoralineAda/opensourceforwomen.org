class CreateProjectsUsers < ActiveRecord::Migration
  def change
    create_table :projects_users do |t|
      t.integer :project_id
      t.integer :user_id
    end
  end
end
