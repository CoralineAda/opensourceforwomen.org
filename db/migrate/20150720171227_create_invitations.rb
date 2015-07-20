class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :invitee_email
      t.text   :message
      t.references :user
      t.timestamps
    end
  end
end
