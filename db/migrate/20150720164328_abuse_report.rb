class AbuseReport < ActiveRecord::Migration
  def up
    create_table :abuse_reports do |t|
      t.string :status
      t.text   :description
      t.timestamps null: false
      t.references :reporter_id
      t.references :offender_id
    end
  end
end
