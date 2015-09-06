class FixOffenderIdInAbuseReport < ActiveRecord::Migration
  def change
    rename_column :abuse_reports, :offender_id_id, :offender_id
  end
end
