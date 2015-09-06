class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :email
      t.boolean :synced_to_mailchimp
      t.timestamps
    end
  end
end
