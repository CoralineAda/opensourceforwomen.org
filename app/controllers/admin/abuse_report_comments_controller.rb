class Admin::AbuseReportCommentsController < Admin::AdminController

  before_action :require_login

  def create
    comment = AbuseReportComment.create(
      comment: params[:comment],
      abuse_report_id: params[:abuse_report_id],
      user: current_user
    )
    redirect_to admin_abuse_report_path(params[:abuse_report_id])
  end

end