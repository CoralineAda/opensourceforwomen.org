class AddConversationIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :conversation_id, :integer
  end
end
