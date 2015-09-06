class SetReadDefaultOnMessages < ActiveRecord::Migration
  def change
    change_column :messages, :is_read, :boolean, default: false
  end
end
