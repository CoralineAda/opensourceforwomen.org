class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string  :name
      t.string  :full_name
      t.text    :description
      t.string  :homepages
      t.string  :language
      t.string  :repo_url
      t.string  :remote_id
      t.boolean :has_coc
      t.timestamps
    end
  end
end
