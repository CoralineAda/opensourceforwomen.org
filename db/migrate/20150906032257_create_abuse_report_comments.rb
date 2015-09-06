class CreateAbuseReportComments < ActiveRecord::Migration
  def change
    create_table :abuse_report_comments do |t|
      t.integer :abuse_report_id
      t.text :comment
      t.integer :user_id
      t.timestamps
    end
  end
end
