class AbuseReport < ActiveRecord::Base

  belongs_to :reporter, class_name: "User"
  belongs_to :offender, class_name: "User"
  has_many :abuse_report_comments

  def suspend_account
    self.offender.freeze_account
  end

  def comments
    abuse_report_comments
  end

end