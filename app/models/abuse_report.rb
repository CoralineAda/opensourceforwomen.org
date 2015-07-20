class AbuseReport < ActiveRecord::Bases

  belongs_to :reporter, class_name: "User"
  belongs_to :offender, class_name: "User"

  def suspend_account
    self.offender.freeze_account
  end

end