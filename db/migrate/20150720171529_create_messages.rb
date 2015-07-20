class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string  :subject
      t.text    :body
      t.boolean :is_read
      t.references :sender
      t.references :recipient
      t.timestamps
    end
  end
end
