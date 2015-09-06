class AddResolvedFlagToAbuseReports < ActiveRecord::Migration
  def change
    add_column :abuse_reports, :is_resolved, :boolean, default: false
  end
end
