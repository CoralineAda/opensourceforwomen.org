class AddIsSeentoMessages < ActiveRecord::Migration
  def change
    add_column :messages, :is_seen, :boolean, default: false
  end
end
