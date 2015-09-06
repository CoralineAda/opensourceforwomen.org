class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :twitter_handle
      t.string  :github_username
      t.boolean :accepts_coc
      t.boolean :accepts_terms
      t.boolean :subscribed
      t.boolean :is_frozen
      t.boolean :is_admin
      t.string :email,            :null => false
      t.string :crypted_password
      t.string :salt
      t.timestamps
    end

    add_index :users, :email, unique: true

  end
end
