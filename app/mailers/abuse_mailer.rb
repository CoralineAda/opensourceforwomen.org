class AbuseMailer < ApplicationMailer

  def abuse_email(abuse_report_id)
    @abuse_report = AbuseReport.find(abuse_report_id)
    @reporter = @abuse_report.reporter
    @offender = @abuse_report.offender
    mail(to: ENV['ADMIN_EMAIL'], subject: "OS4W: Abuse Report")
  end

end