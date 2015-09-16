class CreateFeaturedProjects < ActiveRecord::Migration
  def change
    create_table :featured_projects do |t|
      t.string :name
      t.integer :user_id
      t.string :language
      t.text :description
      t.string :url
      t.boolean :is_active
      t.timestamps null: false
    end
  end
end
