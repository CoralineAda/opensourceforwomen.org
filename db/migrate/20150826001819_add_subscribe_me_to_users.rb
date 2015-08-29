class AddSubscribeMeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscribe_me, :boolean
  end
end
