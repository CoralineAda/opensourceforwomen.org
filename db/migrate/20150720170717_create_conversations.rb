class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.timestamps
    end
    create_join_table :conversations, :users do |t|
      t.index :conversation_id
      t.index :user_id
    end
  end
end
