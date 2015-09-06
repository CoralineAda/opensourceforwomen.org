class AbuseReportComment < ActiveRecord::Base

  validates_presence_of :comment

  belongs_to :abuse_report
  belongs_to :user

end