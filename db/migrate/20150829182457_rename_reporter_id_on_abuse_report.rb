class RenameReporterIdOnAbuseReport < ActiveRecord::Migration
  def change
    remove_column :abuse_reports, :reporter_id_id
    add_column :abuse_reports, :reporter_id, :integer
  end
end
